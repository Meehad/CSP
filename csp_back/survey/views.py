from rest_framework import status
from .models import Survey_Q, Survey_A
from .serializers import SurveyqSerializer, SurveyaSerializer
from rest_framework.response import Response
from rest_framework.decorators import api_view
from csp_log.models import UserProfile

# create views here


@api_view(['POST'])
def createSurvey(request):
    data = request.data
    survey = Survey_Q.objects.create(
        dept_id=data['dept_id'],
        question=data['question'],
    )
    serializer = SurveyqSerializer(survey, many=False)
    return Response(serializer.data)

@api_view(['GET'])
def submit_survey(request):
    if request.method == "GET":
        id_number = UserProfile.objects.get(id_number=id_number)
        question = Survey_Q.objects.get(question=question)
        answer = request.GET.get('answer')
        Survey_A(id_number=id_number, question=question,
                 answer=answer)
        return Response({}, status=status.HTTP_200_OK)
