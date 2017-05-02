from django.conf.urls import url
from rest_framework.urlpatterns import format_suffix_patterns
from . import views

urlpatterns = [
    url(r'^sonos/$', views.SonosList.as_view()),
    url(r'^listen/$', views.SonosListen.as_view())
]

urlpatterns = format_suffix_patterns(urlpatterns)
