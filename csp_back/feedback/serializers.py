from .models import event,feedback
from rest_framework import serializers

class EventSerializer(serializers.ModelSerializer):
    class Meta:
        model = event
        fields = "__all__"

class FeedbackSerializer(serializers.ModelSerializer):
    class Meta:
        model = feedback
        fields = "__all__"