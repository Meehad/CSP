from rest_framework import serializers
from .models import Survey_Q, Survey_A

# Create your views here.


class SurveyqSerializer(serializers.ModelSerializer):
    id = serializers.CharField(source='id_str', read_only=True)

    class Meta:
        model = Survey_Q
        fields = ['id', 'name', 'question', 'is_options', 'options', 'time']


class SurveyaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Survey_A
        fields = '__all__'
