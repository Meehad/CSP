from rest_framework import serializers
from .models import UserProfile, DeptProfile, DeptLogin, CitizenLogin


class UserProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserProfile
        fields = "__all__"


class DeptProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = DeptProfile
        fields = "__all__"


class DeptSerializer(serializers.ModelSerializer):
    class Meta:
        model = DeptLogin
        fields = '__all__'


class CitizenSerializer(serializers.ModelSerializer):
    class Meta:
        model = CitizenLogin
        fields = '__all__'
