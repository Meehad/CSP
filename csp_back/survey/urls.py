# urls.py

from django.urls import path
from . import views

urlpatterns = [
    path('survey_create/',views.createSurvey),
    path('submit_survey/', views.submit_survey),
]
