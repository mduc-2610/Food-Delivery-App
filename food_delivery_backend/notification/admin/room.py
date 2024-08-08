from django.contrib import admin

class DirectRoomAdmin(admin.ModelAdmin):
    list_display = ('name', 'user1', 'user2')
    search_fields = ('name', 'user2__phone_number', 'user2__phone_number')
    list_filter = ('user1', 'user2')

class GroupRoomAdmin(admin.ModelAdmin):
    list_display = ('name',)
    search_fields = ('name',)
    # filter_horizontal = ('members',)

    # def get_member_count(self, obj):
    #     return obj.members.count()
    # get_member_count.short_description = 'Member Count'
