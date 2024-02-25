from django.contrib import admin
from django.urls import path, include
from django.conf.urls.static import static
from django.conf import settings

urlpatterns = [
    path("admin/", admin.site.urls),
    path("csp_log/", include('csp_log.urls')),
    path("feedback/", include('feedback.urls')),
    path("complaint/", include('complaint.urls')),
    path("", include('survey.urls')),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL,
                          document_root=settings.MEDIA_ROOT)
