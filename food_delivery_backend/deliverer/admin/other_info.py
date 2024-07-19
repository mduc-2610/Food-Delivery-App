# deliverer/admin.py
from django.contrib import admin

class OtherInfoAdmin(admin.ModelAdmin):
    list_display = ['occupation', 'details']
    search_fields = ['occupation', 'details']
    readonly_fields = ['judicial_record']

    def get_readonly_fields(self, request, obj=None):
        if obj:
            return self.readonly_fields + ['judicial_record']
        return self.readonly_fields
