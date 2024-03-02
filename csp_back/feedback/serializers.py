from .models import event, feedback
from rest_framework import serializers


class EventSerializer(serializers.ModelSerializer):
    class Meta:
        model = event
        fields = ["name", "event_name", "event_details", "event_img", "date"]


class FeedbackSerializer(serializers.ModelSerializer):
    class Meta:
        model = feedback
        fields = "__all__"
