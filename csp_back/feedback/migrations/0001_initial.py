# Generated by Django 4.2.7 on 2024-02-17 15:24

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):
    initial = True

    dependencies = [
        ("csp_log", "0002_citizenlogin_deptlogin_and_more"),
    ]

    operations = [
        migrations.CreateModel(
            name="event",
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
                ("event_name", models.TextField(max_length=105)),
                ("event_details", models.TextField()),
                ("date", models.DateTimeField(auto_now_add=True)),
                (
                    "dept_id",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        to="csp_log.deptprofile",
                    ),
                ),
            ],
        ),
        migrations.CreateModel(
            name="feedback",
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
                ("feedback", models.TextField(max_length=255)),
                ("rating", models.IntegerField(default=0)),
                (
                    "event_name",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE, to="feedback.event"
                    ),
                ),
                (
                    "id_number",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        to="csp_log.userprofile",
                    ),
                ),
            ],
        ),
    ]