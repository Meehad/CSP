from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import UserProfileSerializer, DeptProfileSerializer, CitizenSerializer, DeptSerializer
from .models import UserProfile, DeptProfile, CitizenLogin, DeptLogin
from django.shortcuts import redirect, render
from rest_framework.decorators import api_view
from django.contrib.auth import logout
from rest_framework.response import Response
from rest_framework import status, generics
import random
from django.contrib.auth import logout, login, authenticate
from rest_framework.authtoken.models import Token
from django.core.exceptions import ObjectDoesNotExist


@api_view(['POST'])
def createProfile(request):
    data = request.data
    profile = UserProfile.objects.create(
        name=data['name'],
        date_of_birth=data['date_of_birth'],
        id_number=data['id_number'],
        address=data['address'],
        # Assuming a simple phone number format
        phone_number=data['phone_number'],
        image=data['image'],
    )
    serializer = UserProfileSerializer(profile, many=False)
    return Response(serializer.data)


@api_view(['GET'])
def showProfile(request, pk):
    profile = UserProfile.objects.get(id_number=pk)
    serializer = UserProfileSerializer(profile, many=False)
    return Response(serializer.data)


@api_view(['GET'])
def showProfiles(request):
    profiles = UserProfile.objects.all()
    serializer = UserProfileSerializer(profiles, many=True)
    return Response(serializer.data)


@api_view(['POST'])
def createdeptProfile(request):
    data = request.data
    profile = DeptProfile.objects.create(
        name=data['name'],
        id_number=data['id_number'],
        # Assuming a simple phone number format
        head=data['head'],
        image=data['image'],
    )
    serializer = DeptProfileSerializer(profile, many=False)
    return Response(serializer.data)


@api_view(['GET'])
def showdeptProfile(request, pk):
    profile = DeptProfile.objects.get(dept_id=pk)
    serializer = DeptProfileSerializer(profile, many=False)
    return Response(serializer.data)


@api_view(['GET'])
def showdeptProfiles(request):
    profiles = DeptProfile.objects.all()
    serializer = DeptProfileSerializer(profiles, many=True)
    return Response(serializer.data)


@api_view(['POST'])
def clogin(request):
    entered_id = request.data.get('id_number', '')

    # Validate the length of id_number before using the serializer
    if len(entered_id) <= CitizenLogin._meta.get_field('id_number').max_length:
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


@api_view(['POST'])
def logout_User(request):
    logout(request)
    return redirect('login')


@api_view(['POST'])
def dlogin(request):
    if request.method == 'POST':
        entered_id = request.data.get('dept_id', '')
        entered_password = request.data.get('dpassword', '')
        serializer = DeptSerializer(
            data={'dept_id': entered_id, 'dpassword': entered_password})
        if serializer.is_valid():
            try:
                # Query UserProfile using the entered ID
                user_profile = DeptProfile.objects.get(
                    dept_id=entered_id, dpassword=entered_password)
                # If found, you can do further processing or return some data
                return Response({}, status=status.HTTP_200_OK)
            except DeptProfile.DoesNotExist:
                # If not found, you can handle this case accordingly
                return Response({'message': 'ID does not exist in DeptProfile model'}, status=status.HTTP_404_NOT_FOUND)
            except Exception as e:
                # Handle other exceptions if necessary
                return Response({'message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        else:
            # If the input is not valid, return validation error details
            return Response({'errors': serializer.errors}, status=status.HTTP_400_BAD_REQUEST)
