from django.utils.safestring import mark_safe
from django.contrib import admin

from .models import Image


class ImageAdmin(admin.ModelAdmin):
    def image(self, obj):
        print(obj.image.url)
        return mark_safe('<img src="{obj.image.url}" style="width:100px;height:auto;">')

    list_display = ('title', 'image')


admin.site.register(Image, ImageAdmin)
