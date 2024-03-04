# urls.py

from django.urls import path
from . import views

urlpatterns = [
    path('survey_create/',views.createSurvey),
    path('questions/', views.Questions_view),
    path('submit_survey/', views.submit_survey),
    path('answers/', views.Answers_view),
]