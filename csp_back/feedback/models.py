from django.db import models
from csp_log.models import UserProfile, DeptProfile

# Create your models here.
class event(models.Model):
    dept_id = models.ForeignKey(DeptProfile, on_delete=models.CASCADE)
    event_name = models.TextField(max_length=105, unique=True)
    event_details = models.TextField()
    date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Event from {self.dept_id}"

class feedback(models.Model):
    id_number = models.ForeignKey(UserProfile, on_delete=models.CASCADE)
    event_name = models.ForeignKey(event, on_delete=models.CASCADE)
    feed = models.TextField(max_length=255)
    rating = models.IntegerField(default=0)
    date_marked = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Feedback from {self.id_number}"
