from django.contrib import admin

# Register your models here.

from .models import Author, Sound

class SoundAdmin(admin.ModelAdmin):
    list_display   = ('title_text', 'author',
                      'play_count_integer', 'pub_date')
    list_filter    = ('author',)
    ordering       = ('pub_date', 'play_count_integer', )
    search_fields  = ('title_text', 'author')

admin.site.register(Author)
admin.site.register(Sound, SoundAdmin)
