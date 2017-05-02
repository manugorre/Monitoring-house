from django.utils import timezone
from django.http import Http404
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

from .models import Author, Sound
from .serializers import SoundSerializer, AuthorSerializer
from rest_framework import generics

import operator
import itertools
import shutil
import os


class SoundBox(APIView):

    def get(self, request, format=None):
        sounds = Sound.objects.all()
        authors = Author.objects.all()

        sounds = SoundSerializer(sounds, many=True)
        authors = AuthorSerializer(authors, many=True)

        sounds_grouped = []
        for key, items in itertools.groupby(sounds.data, operator.itemgetter('author_id')):
            sounds_grouped.append(list(items))

        data = {
            "sounds": sounds_grouped,
            "authors": authors.data
        }

        return Response(data)


class SoundList(generics.ListAPIView):
    serializer_class = SoundSerializer

    def get_queryset(self):
        author = self.request.query_params.get('author', None)

        sounds = Sound.objects.all()
        if author is not None:
            sounds = sounds.filter(author=author)

        return sounds


class SoundDetails(APIView):

    def get_object(self, pk):
        try:
            return Sound.objects.get(pk=pk)
        except Sound.DoesNotExist:
            raise Http404

    def get(self, request, pk, format=None):
        snippet = self.get_object(pk)
        serializer = SoundSerializer(snippet)
        return Response(serializer.data)

    def delete(self, request, pk, format=None):
        snippet = self.get_object(pk)
        snippet.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)


class SoundImport(APIView):

    def get(self):
        for dirname in os.listdir('./static/data'):

                q = Author(name_text=dirname)
                q.save()

                deposite_folder_path = os.path.join(os.getcwd(), 'static/data', dirname, 'deposit')
                sounds_folder_path = os.path.join(os.getcwd(), 'static/data', dirname, 'sounds')

                for filename in os.listdir(deposite_folder_path):
                    sound_title = os.path.splitext(filename)[0]

                    formated_file_name = filename.replace(" ", "-")

                    q.sound_set.create(
                        title_text=sound_title,
                        file_name_text=filename,
                        pub_date=timezone.now()
                    )

                    deposite_path = os.path.join(deposite_folder_path, filename)
                    destination_path = os.path.join(sounds_folder_path, formated_file_name)

                    shutil.move(deposite_path, destination_path)

        sounds = Sound.objects.all()
        serializer = SoundSerializer(sounds)
        return Response(serializer.data)
