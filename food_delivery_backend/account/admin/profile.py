from django.contrib import admin

class ProfileAdmin(admin.ModelAdmin):
    list_display = ['user', 'name', 'gender', 'date_of_birth']
    search_fields = ['name', 'user__username', 'user__email']
