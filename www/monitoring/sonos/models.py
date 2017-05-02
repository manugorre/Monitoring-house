from __future__ import unicode_literals

from django.db import models


class Sonos(models.Model):
    uid = models.CharField(max_length=50)
    ip_address = models.CharField(max_length=50)
    player_name = models.CharField(max_length=100)
    model_name = models.CharField(max_length=100)
    player_icon_url = models.CharField(max_length=100)
    is_selected = models.BooleanField(default=False)
    updated_at = models.DateTimeField(auto_now_add=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __unicode__(self):
        return self.player_name
