from django.db import models

# Create your models here.


class UserProfile(models.Model):
    name = models.CharField(max_length=100)
    date_of_birth = models.DateField()
    id_number = models.CharField(max_length=10, unique=True)
    address = models.TextField()
    # Assuming a simple phone number format
    phone_number = models.CharField(max_length=10)
    # Assumes images will be uploaded to 'media/user_images/'
    image = models.ImageField(upload_to='user_images/')

    def __str__(self):
        return self.id_number


class DeptProfile(models.Model):
    name = models.CharField(max_length=100, unique=True)
    dept_id = models.CharField(max_length=10, unique=True)
    # Assuming a simple phone number format
    head = models.CharField(max_length=100)
    # Assumes images will be uploaded to 'media/user_images/'
    image = models.ImageField(upload_to='dept_images/')
    dpassword = models.CharField(max_length=10)

    def __str__(self):
        return f"{self.dept_id},{self.name}"


class CitizenLogin(models.Model):
    id_number = models.CharField(max_length=10)
    def __str__(self):
        return self.id_number


class DeptLogin(models.Model):
    dept_id = models.CharField(max_length=10)
    dpassword = models.CharField(max_length=10)
    def __str__(self):
        return self.dept_id
