from django.urls import path
from gov_pdf import views
from .views import PDFDocumentUploadView, download_pdf

urlpatterns = [
    path('upload-pdf/', PDFDocumentUploadView.as_view(), name='upload-pdf'),
    path('pdfview/', views.PDFview, name='pdfview'),
    path('uploadpdf/', views.upload_pdf, name='uploadpdf'),
    path('pdfdept/<str:dept_name>/', views.PDFdept, name='pdfdept'),
    path('download_pdf/<int:pdf_id>/', download_pdf, name='download_pdf'),
]
