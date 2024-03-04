# Generated by Django 5.0.1 on 2024-02-25 18:57

import django.utils.timezone
from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        (
            "feedback",
            "0002_rename_feedback_feedback_feed_feedback_date_marked_and_more",
        ),
    ]

    operations = [
        migrations.AddField(
            model_name="event",
            name="event_img",
            field=models.ImageField(
                default=django.utils.timezone.now, upload_to="event_images/"
            ),
            preserve_default=False,
        ),
    ]