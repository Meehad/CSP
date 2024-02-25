from django.shortcuts import render
from rest_framework.decorators import api_view
from rest_framework.response import Response
from csp_log.models import UserProfile
from .models import event, feedback
from .serializers import EventSerializer
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
    data = request.data
    eventc = event.objects.create(
        dept_id=data['dept_id'],
        event_name=data['event_name'],
        events_details=data['event_details'],
    )
    serializer = EventSerializer(eventc, many=False)
    return Response(serializer.data)
