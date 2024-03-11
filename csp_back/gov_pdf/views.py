from django.http import FileResponse, HttpResponse
from urllib.parse import quote as urlquote
from rest_framework import generics
from .models import PDFDocument
from .serializers import PDFDocumentSerializer
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import status

class PDFDocumentUploadView(generics.CreateAPIView):
    queryset = PDFDocument.objects.all()
    serializer_class = PDFDocumentSerializer

@api_view(['GET'])
def PDFview(request):
    pdfs = PDFDocument.objects.all()
    serializer = PDFDocumentSerializer(pdfs, many=True)
    return Response(serializer.data)

@api_view(['GET'])
def download_pdf(request, pdf_id):
    try:
        pdf_document = PDFDocument.objects.get(id=pdf_id)
        pdf_file_path = pdf_document.pdf_file.path
        with open(pdf_file_path, 'rb') as pdf_file:
            response = HttpResponse(pdf_file.read(), content_type='application/pdf')
            response['Content-Disposition'] = f'attachment; filename="{urlquote(pdf_document.title)}.pdf"'
            return response
    except PDFDocument.DoesNotExist:
        return Response({'error': 'PDF not found'}, status=status.HTTP_404_NOT_FOUND)