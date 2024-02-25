from django.contrib import admin
from .models import feedback, event

# Register your models here.
@admin.register(event)
class Event(admin.ModelAdmin):
    list_display = ['dept_id', 'event_name',
                    'event_details', 'date']
    readonly_fields = ['date']

@admin.register(feedback)
class Feedback(admin.ModelAdmin):
    list_display = ['id_number', 'event_name',
                    'feed', 'rating', 'date_marked']
    readonly_fields = ['date_marked']
