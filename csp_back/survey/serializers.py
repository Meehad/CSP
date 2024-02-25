from rest_framework import serializers
from .models import Survey_Q,Survey_A

# Create your views here.
class SurveyqSerializer(serializers.ModelSerializer):
    class Meta:
        model = Survey_Q
        fields = '__all__'

class SurveyaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Survey_A
        fields = '__all__'