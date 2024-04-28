from django.shortcuts import redirect
from rest_framework import status
from csp_log.models import DeptProfile
from csp_log.serializers import DeptProfileSerializer
from .models import Survey_Q, Survey_A
from .serializers import SurveyqSerializer, SurveyaSerializer
from rest_framework.response import Response
from rest_framework.decorators import api_view
from django.db.models import Count
# create views here


@api_view(['POST'])
def createSurvey(request):
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

@api_view(['GET'])
def questiontobeanswered(request, pk):
    try:
        # Filter the answered questions for the specified user
        answered = Survey_A.objects.filter(id_number=pk)

        if answered:
            answered_questions = [a.question.id for a in answered]

            # Exclude answered questions from all available questions
            unanswered_questions = Survey_Q.objects.exclude(
                id__in=answered_questions)

            # Serialize the unanswered questions
            serializer = SurveyqSerializer(unanswered_questions, many=True)

            return Response(serializer.data)
        else:
            # Redirect the user to another view when there are no answered questions
            return redirect(Questions_view)

    except Exception as e:
        return Response({"error": str(e)}, status=500)


@api_view(['GET'])
def answers_by_department(request, dept_name):
    try:
        # Get all Survey_Q objects for the given department name
        survey_q_objects = Survey_Q.objects.filter(
            name__name__iexact=dept_name)

        # Check if any Survey_Q object exists for the given department name
        if survey_q_objects.exists():
            answers_data = []  # List to store answers for all questions
            for survey_q_object in survey_q_objects:
                # Get the Survey_A objects for the specific Survey_Q object
                answers = Survey_A.objects.filter(question=survey_q_object)

                for answer in answers:
                    answers_data.append(answer)

            serializer = SurveyaSerializer(answers_data, many=True)
            return Response(serializer.data)
        else:
            return Response({"error": "Survey_Q object not found for the given department name."}, status=404)
    except Exception as e:
        return Response({"error": str(e)}, status=500)


@api_view(['GET'])
def optionstopie(request, dept_name):
    try:
        # Get all Survey_Q objects for the given department name
        survey_q_objects = Survey_Q.objects.filter(
            name__name__iexact=dept_name)

        # Check if any Survey_Q object exists for the given department name
        if survey_q_objects.exists():
            options_count = []
            for survey_q in survey_q_objects:
                if survey_q.is_options:
                    # Count the occurrences of each option for the current question
                    option_counts = Survey_A.objects.filter(question=survey_q).values(
                        'answer').annotate(count=Count('answer'))

                    # Create a dictionary of option counts for the current question
                    question_data = {
                        "question": survey_q.question,
                        "options": {option['answer']: option['count'] for option in option_counts}
                    }
                    options_count.append(question_data)

            return Response(options_count)
        else:
            return Response({"error": "Survey_Q object not found for the given department name."}, status=404)
    except Exception as e:
        return Response({"error": str(e)}, status=500)
