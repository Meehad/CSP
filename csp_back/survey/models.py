# models.py
from django.db import models
from django.contrib.postgres.fields import ArrayField
from csp_log.models import UserProfile, DeptProfile


class Survey_Q(models.Model):
    name = models.ForeignKey(
        DeptProfile, to_field='name', on_delete=models.CASCADE)
    question = models.CharField(max_length=255, unique=True)
    is_options = models.BooleanField(default=False)
    options = ArrayField(models.CharField(
        max_length=100), blank=True, null=True)
    time = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.question}"

    def id_str(self):
        return str(self.id)


class Survey_A(models.Model):
    id_number = models.ForeignKey(
        UserProfile, to_field='id_number', on_delete=models.CASCADE)
    question = models.ForeignKey(
        Survey_Q, to_field='question', on_delete=models.CASCADE)
    answer = models.TextField(max_length=255)
    time_sub = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.answer
