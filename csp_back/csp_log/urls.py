from django.urls import path
from . import views

urlpatterns = [
    path('createprofile/', views.createProfile),
    path('<str:pk>/showprofile/', views.showProfile),
    path('showprofiles/', views.showProfiles),
    path('createdeptprofile/', views.createdeptProfile),
    path('<str:pk>/showdeptprofile/', views.showdeptProfile),
    path('showdeptprofiles/', views.showdeptProfiles),
    path("clogin/", views.clogin, name='clogin'),
    path('dlogin/', views.dlogin, name='dlogin'),
    path('logout_user/', views.logout_User, name='logout'),
]
