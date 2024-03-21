from django.urls import path
from . import views

urlpatterns = [
    path('event/', views.Event_post),
    path('events_view/', views.Events_view),
    path('feed/', views.Review_rate),
    path('feeds_view/', views.Feedbacks_view),
    path('feed_view/<str:pk>/',
         views.feedbacktobeanswered, name='feedbacktobeanswered'),
    path('avg_feed/<str:dept_name>/',
         views.avg_rating, name='averageRating'),
    path('feedbyevent/<str:event_name>/',
         views.feedbyevent, name='feedbyevent'),
]
