# Generated by Django 4.2.7 on 2024-02-17 20:06

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("complaint", "0001_initial"),
    ]

    operations = [
        migrations.AlterField(
            model_name="complaint",
            name="is_read",
            field=models.BooleanField(default=False, editable=False),
        ),
        migrations.AlterField(
            model_name="complaint",
            name="sub",
            field=models.CharField(max_length=255),
        ),
    ]
