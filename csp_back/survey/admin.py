from django.contrib import admin
from .models import Survey_Q,Survey_A

# Register your models here.
@admin.register(Survey_Q)
class SQ(admin.ModelAdmin):
    list_display = ['name', 'question', 'time']
    readonly_fields = ['time']

@admin.register(Survey_A)
class Feedback(admin.ModelAdmin):
    list_display = ['name','id_number', 'question', 'answer', 'time_sub']
    readonly_fields = ['time_sub']