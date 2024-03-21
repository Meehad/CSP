from django.http import Http404
from django.shortcuts import get_object_or_404, render
from rest_framework.decorators import api_view
from rest_framework.response import Response
from csp_log.models import UserProfile
from .models import event, feedback
from .serializers import AvgFeedbackSerializer, EventSerializer, FeedbackSerializer
from rest_framework import status
from django.db.models import Avg
from django.core.exceptions import ObjectDoesNotExist
from rest_framework.exceptions import NotFound

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


@api_view(['GET'])
def avg_rating(request, dept_name):
    try:
        event_list = event.objects.filter(name__name__iexact=dept_name)
        feed_data = []
        for ev in event_list:
            try:
                avg_rating = feedback.objects.filter(event_name=ev).aggregate(
                    avg_rating=Avg('rating'))['avg_rating']
            except ObjectDoesNotExist:
                # If no feedback, set average rating to 0
                avg_rating = 0

            feed_data.append({
                "event_name": ev.event_name,
                "avg_rating": avg_rating
            })

        serializer = AvgFeedbackSerializer(feed_data, many=True)
        return Response(serializer.data)
    except ObjectDoesNotExist:
        raise NotFound("Department or event not found")
    except Exception as e:
        return Response({"error": str(e)}, status=500)


@api_view(['GET'])
def feedbyevent(request, event_name):
    try:
        # Get all feedback objects for the given event name
        feedback_objects = feedback.objects.filter(
            event_name__event_name__iexact=event_name)

        # Check if any feedback object exists for the given event name
        if feedback_objects.exists():
            serializer = FeedbackSerializer(feedback_objects, many=True)
            return Response(serializer.data)
        else:
            return Response({"error": "Feedback object not found for the given event name."}, status=404)
    except Exception as e:
        return Response({"error": str(e)}, status=500)
