import json
from pathlib import Path
from django.http import JsonResponse, HttpResponse
from django.views import View
from .models import Image


class Viewer(View):
    @staticmethod
    def get(request):
        image_root = Path('images/')
        info = []
        for p in sorted(image_root.glob('**/*.png')):
            info += [{'title': str(p.stem), 'path': str(p)}]

        return HttpResponse(json.dumps(info, indent=True), status=200)


class ViewerByTitle(View):
    def get(self, request, title):
        image_root = Path('images/')
        name = title + '.png'
        path = image_root / name
        if path.exists():
            info = {'title': title, 'path': str(path)}
        return HttpResponse(json.dumps(info, indent=True), status=200)


class ImageViewer(View):
    def get(self, request, title):
        with open(f'images/{title}.png', 'rb') as f:
            binary = f.read()
        return HttpResponse(binary, content_type='image/png')
