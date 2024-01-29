# citizen/models.py
from django.db import models

class Citizen(models.Model):
    id_number = models.CharField(max_length=10)

    def __str__(self):
        return self.id_number
