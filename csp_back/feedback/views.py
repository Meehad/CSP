from django.http import Http404
from django.shortcuts import get_object_or_404, render
from rest_framework.decorators import api_view
from rest_framework.response import Response
from csp_log.models import UserProfile
from .models import event, feedback
from .serializers import EventSerializer, FeedbackSerializer
from rest_framework import status
from django.shortcuts import redirect

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


@api_view(['GET'])
def feedbacktobeanswered(request, pk):
    try:
        # Get the UserProfile object for the given id_number
        user_profile = get_object_or_404(UserProfile, id_number=pk)

        # Filter the feedback for the specified user
        user_feedback = feedback.objects.filter(id_number=user_profile)

        if user_feedback:
            given_feedback_events = [a.event_name.id for a in user_feedback]

            # Exclude events with feedback from all available events
            unanswered_events = event.objects.exclude(
                id__in=given_feedback_events)

            # Serialize the unanswered events
            serializer = EventSerializer(unanswered_events, many=True)

            return Response(serializer.data)
        else:
            # Return all events if there is no feedback from the user
            all_events = event.objects.all()
            serializer = EventSerializer(all_events, many=True)
            return Response(serializer.data)

    except Http404:
        return Response({"error": "UserProfile not found for the given id_number."}, status=404)
    except Exception as e:
        return Response({"error": str(e)}, status=500)
