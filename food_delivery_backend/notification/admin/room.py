from django.contrib import admin

class DirectRoomAdmin(admin.ModelAdmin):
    list_display = ( 'user1', 'user2')
    search_fields = ( 'user2__phone_number', 'user2__phone_number')
    list_filter = ('user1', 'user2')

class GroupRoomAdmin(admin.ModelAdmin):
    list_display = ()
    search_fields = ()
    # filter_horizontal = ('members',)

    # def get_member_count(self, obj):
    #     return obj.members.count()
    # get_member_count.short_description = 'Member Count'
