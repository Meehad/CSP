# Generated by Django 4.2.7 on 2024-02-17 12:55

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("csp_log", "0001_initial"),
    ]

    operations = [
        migrations.CreateModel(
            name="CitizenLogin",
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
                ("id_number", models.CharField(max_length=10)),
            ],
        ),
        migrations.CreateModel(
            name="DeptLogin",
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
                ("dept_id", models.CharField(max_length=10)),
                ("dpassword", models.CharField(max_length=10)),
            ],
        ),
        migrations.RenameField(
            model_name="deptprofile",
            old_name="dept_id_number",
            new_name="dept_id",
        ),
    ]
