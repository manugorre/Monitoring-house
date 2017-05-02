# -*- coding: utf-8 -*-
# Generated by Django 1.10.5 on 2017-04-28 11:42
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Author',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name_text', models.CharField(max_length=200)),
                ('pub_date', models.DateTimeField(auto_now_add=True)),
            ],
        ),
        migrations.CreateModel(
            name='Sound',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title_text', models.CharField(max_length=200)),
                ('file_name_text', models.CharField(max_length=200)),
                ('play_count_integer', models.IntegerField(default=0)),
                ('pub_date', models.DateTimeField(auto_now_add=True)),
                ('author', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='soundBox.Author')),
            ],
        ),
    ]
