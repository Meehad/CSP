#!/bin/bash

# Echo commands and exit on first failure
set -e

# Activate virtual environment (optional but recommended)
python3.9 -m venv env
source env/bin/activate

# Install dependencies
echo "Installing dependencies..."
python3.9 -m pip install -r requirements.txt

# Make migrations and migrate
echo "Applying database migrations..."
python3.9 manage.py makemigrations --noinput
python3.9 manage.py migrate --noinput

# Collect static files
echo "Collecting static files..."
python3.9 manage.py collectstatic --noinput --clear

# Deactivate virtual environment
deactivate

echo "Build completed successfully."
