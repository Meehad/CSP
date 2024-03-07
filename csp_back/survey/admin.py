from django.contrib import admin
from .models import Survey_Q, Survey_A

@admin.register(Survey_Q)
class SQ(admin.ModelAdmin):
    list_display = ['name', 'question','is_options','options', 'time']
    readonly_fields = ['time']

@admin.register(Survey_A)
class SA(admin.ModelAdmin):
    list_display = ['id_number', 'question', 'answer', 'time_sub']
    readonly_fields = ['time_sub']