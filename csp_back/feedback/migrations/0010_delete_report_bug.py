# Generated by Django 5.0.1 on 2024-03-12 18:01

from django.db import migrations


class Migration(migrations.Migration):
    dependencies = [
        ("feedback", "0009_report_bug"),
    ]

    operations = [
        migrations.DeleteModel(
            name="report_bug",
        ),
    ]
