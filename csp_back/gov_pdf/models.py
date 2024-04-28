from django.db import models
from csp_log.models import DeptProfile


class PDFDocument(models.Model):
    title = models.CharField(max_length=100)
    name = models.ForeignKey(
        DeptProfile, to_field='name', on_delete=models.CASCADE)
    pdf_file = models.FileField(upload_to='pdfs/')

    def __str__(self):
        return self.title
