# Generated by Django 5.0.1 on 2024-03-09 11:26

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("gov_pdf", "0003_alter_pdfdocument_id"),
    ]

    operations = [
        migrations.AlterField(
            model_name="pdfdocument",
            name="id",
            field=models.BigAutoField(
                auto_created=True, primary_key=True, serialize=False, verbose_name="ID"
            ),
        ),
    ]
