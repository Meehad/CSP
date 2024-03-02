from rest_framework import serializers
from .models import Complaint

class ComplaintSerializer(serializers.ModelSerializer):
    class Meta:
        model = Complaint
        fields = ['id', 'id_number', 'sub', 'prob', 'loc', 'image']
