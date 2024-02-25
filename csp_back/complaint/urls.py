from django.urls import path
from . import views

urlpatterns = [
    path('cpost/', views.Complaint_post),
    path('cget/', views.Complaint_get),
]