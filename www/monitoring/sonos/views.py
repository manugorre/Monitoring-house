from rest_framework.exceptions import NotFound
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from django.utils.translation import ugettext_lazy as _
from .models import Sonos
from .serializers import SonosSerializer
from soundBox.models import Sound
from soco import SoCo
from .utils import get_ip_address


class SonosList(APIView):

    def get(self, request, format=None):

        snippets = Sonos.objects.all()
        serializer = SonosSerializer(snippets, many=True)
        return Response(serializer.data)


class SonosListen(APIView):

    def get(self, request, format=None):
        params = request.query_params
        sound_id = params["sound_id"]
        speaker_id = params["speaker_id"]

        if sound_id is None and speaker_id is None:
            return Response(status=status.HTTP_400_BAD_REQUEST)
        elif sound_id is None or speaker_id is None:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        speaker = Sonos.objects.filter(pk=speaker_id)
        if not speaker:
            raise NotFound(detail=_("No Sonos with this id"))

        sound = Sound.objects.filter(pk=sound_id)
        if not sound:
            raise NotFound(detail=_("No sound with this id"))

        sonos = SoCo(speaker[0].ip_address)
        uri = 'http://' + get_ip_address() + ':8000/static/data/' + sound[0].author.name_text + '/sounds/' + sound[0].file_name_text
        sonos.play_uri(uri, start=True)

        sound[0].play_count_integer += 1
        sound[0].save()

        data = {
            "meta": {
                "code": status.HTTP_200_OK
            }
        }

        return Response(data, status=status.HTTP_200_OK)
