# Generated by Django 4.2.7 on 2024-02-24 17:11

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("complaint", "0005_alter_complaint_id_number"),
    ]

    operations = [
        migrations.AlterField(
            model_name="complaint",
            name="loc",
            field=models.CharField(),
        ),
    ]