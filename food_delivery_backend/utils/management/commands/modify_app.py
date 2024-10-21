import os
import importlib
from django.core.management.base import BaseCommand
from django.core.management import call_command
from django.apps import apps
from django.conf import settings

class Command(BaseCommand):
    help = 'Create an app if it doesn\'t exist, modify its structure, and update settings.py'

    def add_arguments(self, parser):
        parser.add_argument('app_name', type=str, help='Name of the app to create/modify')
        parser.add_argument('-c', '--create', action='store_true', help='Create the app if it doesn\'t exist')

    def handle(self, *args, **kwargs):
        app_name = kwargs['app_name']
        create_flag = kwargs['create']

        if create_flag:
            try:
                apps.set_installed_apps
                apps.get_app_config(app_name)
                self.stdout.write(self.style.WARNING(f"App '{app_name}' already exists."))
            except LookupError:
                call_command('startapp', app_name)
                self.stdout.write(self.style.SUCCESS(f"Created new app: {app_name}"))
                self.update_settings(app_name)
                # self.reload_django_apps() 

        try:
            app_config = apps.get_app_config(app_name)
            app_path = app_config.path
        except LookupError:
            self.stdout.write(self.style.ERROR(f"App '{app_name}' does not exist."))
            return

        self.modify_app_structure(app_path, app_name)
        self.stdout.write(self.style.SUCCESS(f"Modification of '{app_name}' completed."))

    def modify_app_structure(self, app_path, app_name):
        files_to_delete = ['serializers.py', 'models.py', 'views.py', 'admin.py']
        folders_to_create = ['serializers', 'views', 'admin', 'models']
        for filename in files_to_delete:
            file_path = os.path.join(app_path, filename)
            if os.path.exists(file_path):
                os.remove(file_path)
                self.stdout.write(self.style.SUCCESS(f"Deleted file: {filename}"))
            else:
                self.stdout.write(self.style.WARNING(f"File not found: {filename}"))

        for folder in folders_to_create:
            folder_path = os.path.join(app_path, folder)
            if not os.path.exists(folder_path):
                os.makedirs(folder_path)
                self.stdout.write(self.style.SUCCESS(f"Created folder: {folder}"))
            init_file = os.path.join(folder_path, '__init__.py')
            with open(init_file, 'w') as f:
                pass
            self.stdout.write(self.style.SUCCESS(f"Added __init__.py to {folder}"))

        urls_file_path = os.path.join(app_path, 'urls.py')
        if not os.path.exists(urls_file_path):
            with open(urls_file_path, 'w') as f:
                f.write("# urls.py for " + app_name)
            self.stdout.write(self.style.SUCCESS(f"Created urls.py"))

    def update_settings(self, app_name):
        settings_path = self.find_settings_file()
        if not settings_path:
            self.stdout.write(self.style.ERROR("settings.py not found."))
            return

        with open(settings_path, 'r') as f:
            content = f.read()

        app_config = f"{app_name}.apps.{app_name.capitalize()}Config"
        apps.set_installed_apps([app_config])
        if app_config not in content:
            lines = content.split('\n')
            for i, line in enumerate(lines):
                if line.strip().startswith('INSTALLED_APPS'):
                    j = i
                    while not lines[j].strip().endswith(']'):
                        j += 1
                    lines.insert(j, f"\t'{app_config}',")
                    break
        
            with open(settings_path, 'w') as f:
                f.write('\n'.join(lines))

            self.stdout.write(self.style.SUCCESS(f"Added {app_config} to INSTALLED_APPS in settings.py"))
        else:
            self.stdout.write(self.style.WARNING(f"{app_config} already in INSTALLED_APPS"))

    def find_settings_file(self):
        for root, dirs, files in os.walk(settings.BASE_DIR):
            if 'settings.py' in files:
                return os.path.join(root, 'settings.py')
        return None

    # def reload_django_apps(self):
    #     importlib.reload(importlib.import_module(settings.SETTINGS_MODULE))
    #     apps.populate(settings.INSTALLED_APPS)
    #     # apps.app_configs.clear()
    #     # apps.ready = False