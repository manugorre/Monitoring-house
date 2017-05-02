from __future__ import unicode_literals

from django.db import models


class Author(models.Model):
    name_text = models.CharField(max_length=200)
    pub_date = models.DateTimeField(auto_now_add=True)

    def __unicode__(self):
        return self.name_text


class Sound(models.Model):
    author = models.ForeignKey(Author, on_delete=models.CASCADE)
    title_text = models.CharField(max_length=200)
    file_name_text = models.CharField(max_length=200)
    play_count_integer = models.IntegerField(default=0)
    pub_date = models.DateTimeField(auto_now_add=True)

    def __unicode__(self):
        return self.title_text
