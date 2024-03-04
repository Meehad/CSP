from django.shortcuts import render
from rest_framework.decorators import api_view
from rest_framework.response import Response
from csp_log.models import UserProfile
from .models import event, feedback
from .serializers import EventSerializer, FeedbackSerializer
from rest_framework import status

# Create your views here.
@api_view(['POST'])
def Review_rate(request):
    print(request.data)
    serializer = FeedbackSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['POST'])
def Event_post(request):
    print(request.data)
    serializer = EventSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
def Events_view(request):
    events = event.objects.all()
    serializer = EventSerializer(events, many=True)
    return Response(serializer.data)


@api_view(['GET'])
def Feedbacks_view(request):
    feeds = feedback.objects.all()
    serializer = FeedbackSerializer(feeds, many=True)
    return Response(serializer.data)
