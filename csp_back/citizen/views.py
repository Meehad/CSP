from django.shortcuts import render
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from adm.models import UserProfile
from .models import Citizen
from .serializers import CitizenSerializer
import random


@api_view(['POST'])
def login(request):
    entered_id = request.data.get('id_number', '')

    # Validate the length of id_number before using the serializer
    if len(entered_id) <= Citizen._meta.get_field('id_number').max_length:
        # Use the CitizenSerializer to validate the input
        serializer = CitizenSerializer(data={'id_number': entered_id})
        if serializer.is_valid():
            try:
                # Query UserProfile using the entered ID
                user_profile = UserProfile.objects.get(id_number=entered_id)
                otp = random.randint(1000, 9999)
                print(otp)
                # If found, you can do further processing or return some data
                return Response({'otp': otp}, status=status.HTTP_200_OK)
            except UserProfile.DoesNotExist:
                # If not found, you can handle this case accordingly
                return Response({'message': 'ID does not exist in UserProfile model'}, status=status.HTTP_404_NOT_FOUND)
            except Exception as e:
                # Handle other exceptions if necessary
                return Response({'message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        else:
            # If the input is not valid, return validation error details
            return Response({'errors': serializer.errors}, status=status.HTTP_400_BAD_REQUEST)
    else:
        # If id_number exceeds max length, return a specific error response
        return Response({'message': 'ID number exceeds maximum length'}, status=status.HTTP_400_BAD_REQUEST)
