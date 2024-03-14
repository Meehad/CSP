from django.urls import path
from . import views

urlpatterns = [
    path('event/', views.Event_post),
    path('events_view/', views.Events_view),
    path('feed/', views.Review_rate),
    path('feeds_view/', views.Feedbacks_view),
    path('feed_view/<str:pk>/',
         views.feedbacktobeanswered, name='feedbacktobeanswered'),
]
