from django.db import models
from csp_log.models import UserProfile, DeptProfile

# Create your models here.
class Survey_Q(models.Model):
    dept_id = models.ForeignKey(DeptProfile, on_delete=models.CASCADE)
    question = models.TextField(max_length=255, unique=True)
    time = models.DateTimeField(auto_now_add=True)

class Survey_A(models.Model):
    id_number = models.ForeignKey(UserProfile, on_delete=models.CASCADE)
    question = models.ForeignKey(Survey_Q, on_delete=models.CASCADE)
    answer = models.TextField(max_length=255)
    time_sub = models.DateTimeField(auto_now_add=True)
