from django.core.management.base import BaseCommand

class Command(BaseCommand):
    def handle(self, **options):
        from django.apps import apps
        for app in apps.get_app_configs():
            print(app.name)
