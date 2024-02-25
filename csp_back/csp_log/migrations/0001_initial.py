# Generated by Django 4.2.7 on 2024-02-17 11:10

from django.db import migrations, models


class Migration(migrations.Migration):
    initial = True

    dependencies = []

    operations = [
        migrations.CreateModel(
            name="DeptProfile",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("name", models.CharField(max_length=100)),
                ("dept_id_number", models.CharField(max_length=10, unique=True)),
                ("head", models.CharField(max_length=100)),
                ("image", models.ImageField(upload_to="dept_images/")),
                ("dpassword", models.CharField(max_length=10)),
            ],
        ),
        migrations.CreateModel(
            name="UserProfile",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("name", models.CharField(max_length=100)),
                ("date_of_birth", models.DateField()),
                ("id_number", models.CharField(max_length=10, unique=True)),
                ("address", models.TextField()),
                ("phone_number", models.CharField(max_length=10)),
                ("image", models.ImageField(upload_to="user_images/")),
            ],
        ),
    ]
