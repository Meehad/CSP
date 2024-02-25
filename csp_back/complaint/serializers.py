from rest_framework import serializers
from .models import Complaint

class ComplaintSerializer(serializers.ModelSerializer):
    class Meta:
        model = Complaint
        fields = ['id', 'id_number', 'sub', 'prob', 'loc', 'image', 'is_read']
        read_only_fields = ['is_read']  # Make is_read read-only for users
