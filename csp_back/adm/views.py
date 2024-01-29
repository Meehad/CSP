from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import UserProfileSerializer
from .models import UserProfile

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
    profile = UserProfile.objects.get(id=pk)
    serializer = UserProfileSerializer(profile, many=False)
    return Response(serializer.data)
