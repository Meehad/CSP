# Generated by Django 5.0.1 on 2024-03-09 11:15

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("gov_pdf", "0002_pdfdocument_preview_image"),
    ]

    operations = [
        migrations.AlterField(
            model_name="pdfdocument",
            name="id",
            field=models.AutoField(primary_key=True, serialize=False),
        ),
    ]
