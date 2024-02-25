from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from csp_log.models import UserProfile
from .models import Complaint
from .serializers import ComplaintSerializer

@api_view(['GET'])
def Complaint_get(request):
    if request.method == "GET":
        complaints = Complaint.objects.all()
        serializer = ComplaintSerializer(complaints, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

@api_view(['POST'])
def Complaint_post(request):
    print(request.data)
    serializer = ComplaintSerializer(data=request.data)
    if serializer.is_valid():
        # Only set is_read if the user is an admin
        if request.user.is_staff:
            serializer.validated_data['is_read'] = True
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
