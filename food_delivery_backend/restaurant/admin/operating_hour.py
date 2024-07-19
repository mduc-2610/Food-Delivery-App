# operating_hours/admin.py
from django.contrib import admin

class OperatingHourAdmin(admin.ModelAdmin):
    list_display = ['id', 'day_of_week', 'open_time', 'close_time', 'detail_information']
    search_fields = ['day_of_week', 'detail_information__restaurant__name']
    list_filter = ['day_of_week']
