from django.db import models
from csp_log.models import UserProfile


class Complaint(models.Model):
    id_number = models.ForeignKey(
        UserProfile, to_field='id_number', on_delete=models.CASCADE)
    sub = models.CharField(max_length=255)
    prob = models.TextField()
    loc = models.CharField()
    image = models.ImageField(upload_to='admin_images/')
    # Make is_read not editable by users
    is_read = models.BooleanField(default=False, editable=False)

    def __str__(self):
        return f"Complaint from {self.id_number}"
