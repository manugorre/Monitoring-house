from django.conf.urls import url
from rest_framework.urlpatterns import format_suffix_patterns
from . import views

urlpatterns = [
    url(r'^sound/$', views.SoundList.as_view()),
    url(r'^sound/(?P<pk>[0-9]+)', views.SoundDetails.as_view()),
    url(r'^sound/generate/$', views.SoundImport.as_view()),
    url(r'^soundbox/$', views.SoundBox.as_view()),
]

urlpatterns = format_suffix_patterns(urlpatterns)
