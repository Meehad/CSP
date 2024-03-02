from django.contrib import admin
from .models import Complaint

# Register your models here.
class ComplaintAdmin(admin.ModelAdmin):
    # readonly_fields = ['is_read']  # Make is_read readonly in the admin panel
    fields = ['id_number', 'sub', 'prob', 'loc', 'image']  # Specify fields for the admin panel


admin.site.register(Complaint, ComplaintAdmin)
