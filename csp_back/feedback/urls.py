from django.urls import path
from . import views

urlpatterns = [
    path('event/', views.Event_post),
    path('feed/', views.Review_rate),
]
