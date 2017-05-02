from rest_framework import serializers


class SonosSerializer(serializers.Serializer):
    id = serializers.IntegerField(read_only=True)
    uid = serializers.CharField(required=True, max_length=50)
    ip_address = serializers.CharField(read_only=True, max_length=50)
    player_name = serializers.CharField(required=True, max_length=100)
    model_name = serializers.CharField(required=True, max_length=100)
    player_icon_url = serializers.CharField(required=True, max_length=100)
    is_selected = serializers.BooleanField(default=False)
    created_at = serializers.DateTimeField()
    updated_at = serializers.DateTimeField()
