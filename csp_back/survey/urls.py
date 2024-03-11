# urls.py

from django.urls import path
from . import views

urlpatterns = [
    path('survey_create/',views.createSurvey),
    path('questions/', views.Questions_view),
    path('<str:pk>/remaining_q/', views.questiontobeanswered),
    path('submit_survey/', views.submit_survey),
    path('answers/', views.Answers_view),
    path('answer/<str:dept_name>/', views.answers_by_department, name='answers_by_department'),
]