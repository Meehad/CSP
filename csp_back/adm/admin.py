from django.contrib import admin
from .models import UserProfile

# Register your models here.

# Register the model with the admin site
admin.site.register(UserProfile)
