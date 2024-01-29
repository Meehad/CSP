from django.db import models

# Create your models here.
class UserProfile(models.Model):
    name = models.CharField(max_length=100)
    date_of_birth = models.DateField()
    id_number = models.CharField(max_length=10, unique=True)
    address = models.TextField()
    phone_number = models.CharField(max_length=10)  # Assuming a simple phone number format
    image = models.ImageField(upload_to='user_images/')  # Assumes images will be uploaded to 'media/user_images/'

    def __str__(self):
        return self.name