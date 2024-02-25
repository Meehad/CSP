from django.contrib import admin
from csp_log.models import UserProfile,DeptProfile

# Register your models here.
admin.site.register(UserProfile)
admin.site.register(DeptProfile)