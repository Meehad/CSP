from django.shortcuts import render
from rest_framework.decorators import api_view
from rest_framework.response import Response
from csp_log.models import UserProfile
from .models import event, feedback
from .serializers import EventSerializer, FeedbackSerializer
from rest_framework import status

# Create your views here.


@api_view(['GET'])
def Review_rate(request):
    if request.method == "GET":
        id_number = UserProfile.objects.get(id_number=id_number)
        event_name = event.objects.get(event_name=event_name)
        feed = request.GET.get('feed')
        rating = request.GET.get('rating')
        feedback(id_number=id_number, event_name=event_name,
                 feed=feed, rating=rating)
        return Response({}, status=status.HTTP_200_OK)


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
