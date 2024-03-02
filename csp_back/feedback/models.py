from django.db import models
from csp_log.models import UserProfile, DeptProfile

# Create your models here.
class event(models.Model):
    name = models.ForeignKey(DeptProfile,to_field='name', on_delete=models.CASCADE)
    event_name = models.TextField(max_length=105, unique=True)
    event_details = models.TextField()
    event_img = models.ImageField(upload_to='event_images/')
    date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Event from {self.name}"

class feedback(models.Model):
    id_number = models.ForeignKey(UserProfile,to_field='id_number', on_delete=models.CASCADE)
    event_name = models.ForeignKey(event,to_field='event_name', on_delete=models.CASCADE)
    feed = models.TextField(max_length=255)
    rating = models.IntegerField(default=0)
    date_marked = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Feedback from {self.id_number} for the event {self.event_name}"
