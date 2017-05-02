from django.utils import timezone
from .models import Sonos
import soco
import logging

logging.basicConfig()
logger = logging.getLogger(__name__)


def get_speakers_job():

    speakers = soco.discover()

    for speaker in speakers:

        try:
            sonos = Sonos.objects.get(uid=speaker.uid)
            sonos.ip_address = speaker.ip_address
            sonos.player_name = speaker.player_name
            sonos.updated_at = timezone.now()
            sonos.save()

        except Sonos.DoesNotExist:
            speaker_info = speaker.get_speaker_info()
            new_sonos = Sonos(uid=speaker.uid,
                              ip_address=speaker.ip_address,
                              player_name=speaker.player_name,
                              model_name=speaker_info["model_name"],
                              player_icon_url=speaker_info["player_icon"],
                              is_selected=False)
            new_sonos.save()

    pass
