# -*- coding: utf-8 -*-
# Generated by Django 1.10.5 on 2017-04-30 17:56
from __future__ import unicode_literals

from django.db import migrations, models
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('sonos', '0002_sonos_created_at'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='sonos',
            name='is_available',
        ),
        migrations.AddField(
            model_name='sonos',
            name='model_name',
            field=models.CharField(default=django.utils.timezone.now, max_length=100),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='sonos',
            name='player_icon_url',
            field=models.CharField(default=django.utils.timezone.now, max_length=100),
            preserve_default=False,
        ),
    ]
