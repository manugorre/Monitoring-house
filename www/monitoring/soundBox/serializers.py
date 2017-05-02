from rest_framework import serializers
from .models import Author, Sound
import datetime


class AuthorSerializer(serializers.Serializer):
    id = serializers.IntegerField(read_only=True)
    name_text = serializers.CharField(max_length=100)


class SoundSerializer(serializers.Serializer):
    id = serializers.IntegerField(read_only=True)
    author_id = serializers.IntegerField(read_only=True)
    title_text = serializers.CharField(required=True, allow_blank=False, max_length=100)
    file_name_text = serializers.CharField(required=True, allow_blank=False, max_length=100)
    play_count_integer = serializers.IntegerField()
    author = AuthorSerializer()


    #def create(self, validated_data):
    #    return SoundBox.objects.create(**validated_data)

    def update(self, instance, validated_data):
        instance.author_id = validated_data.get('author_id', instance.author_id)
        instance.title_text = validated_data.get('title_text', instance.title_text)
        instance.file_name_text = validated_data.get('file_name_text', instance.file_name_text)
        instance.play_count_integer = validated_data.get('play_count_integer', instance.play_count_integer)
        instance.save()
        return instance