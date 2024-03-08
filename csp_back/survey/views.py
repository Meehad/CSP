from rest_framework import status
from .models import Survey_Q, Survey_A
from .serializers import SurveyqSerializer, SurveyaSerializer
from rest_framework.response import Response
from rest_framework.decorators import api_view
# create views here


@api_view(['POST'])
def createSurvey(request):
    print(request.data)
    serializer = SurveyqSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
def Questions_view(request):
    questions = Survey_Q.objects.all()
    serializer = SurveyqSerializer(questions, many=True)
    return Response(serializer.data)


@api_view(['POST'])
def submit_survey(request):
    print(request.data)
    serializer = SurveyaSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
def Answers_view(request):
    answers = Survey_A.objects.all()
    serializer = SurveyaSerializer(answers, many=True)
    return Response(serializer.data)
