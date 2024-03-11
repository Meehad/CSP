from rest_framework import serializers
from .models import Survey_Q, Survey_A

# Create your views here.


class SurveyqSerializer(serializers.ModelSerializer):
    class Meta:
        model = Survey_Q
        fields = ['name', 'question', 'is_options', 'options', 'time']


class SurveyaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Survey_A
        fields = ['id_number','question','answer','time_sub']
