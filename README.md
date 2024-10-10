# Centralized Survey Portal (CSP)

Centralized Survey Portal (CSP) is an application designed to centralize departments in a district for conducting data collections, managing events, and gathering feedback from citizens. The app is structured to facilitate communication between citizens, departments, and admin users effectively.

## Table of Contents
- [Features](#features)
- [User Roles](#user-roles)
- [Problem Statement](#problem-statement)
- [Our Solution](#our-solution)
- [Advantages](#advantages)
- [Installation](#installation)
- [Setup](#setup)
- [Connecting PostgreSQL with Django](#connecting-postgresql-with-django)
- [Contributing](#contributing)
- [Contact](#contact)

## Problem Statement
In many districts, communication between departments and citizens is often fragmented, leading to inefficient data collection, lack of awareness about events, and difficulties in reporting complaints. The Centralized Survey Portal addresses these challenges by providing a unified platform that streamlines interactions, enhances data collection, and improves overall governance.

## Features
- **Surveys and Feedback:** Conduct and respond to surveys easily.
- **Event Awareness:** Citizens can learn about upcoming events and provide feedback.
- **Complaints Reporting:** Report issues directly to admin using geolocation and photos.
- **Access to Forms:** Download application forms for various departmental needs.
- **Feedback Mechanism:** Collect user feedback and send it to the technical team via email using Flutter.

## User Roles
1. **Citizen:** Normal citizens can participate in surveys, provide feedback, and report complaints.
2. **Departments:** Managed by heads of departments, they oversee survey distribution and event management.
3. **Admin:** District collectors manage the overall operations and ensure smooth functioning.

## Problem Statement
In many districts, communication between departments and citizens is often fragmented, leading to inefficient data collection and event management. CSP addresses these challenges by providing a centralized platform that streamlines interactions and feedback collection.

## Our Solution
The CSP app centralizes various departmental functions, allowing for streamlined data collection, event management, and citizen engagement. By enabling direct feedback and communication channels, we create a more efficient governance model.

## Advantages
- **Streamlined Communication:** Reduces the distance between citizens and departments.
- **User-Centric Design:** Focuses on citizen engagement and satisfaction.
- **Data Analysis:** Facilitates easy data analysis for better decision-making.
- **Comprehensive Features:** Covers all essential functionalities for effective governance.
## Installation

### Prerequisites
Ensure you have the following installed:
- Python (3.x)
- Django
- PostgreSQL
- Flutter
- ADB (Android Debug Bridge)

### Cloning the Repository
1. **Clone the repository:**
   ```bash
   git clone https://github.com/Meehad/CSP.git
   cd CSP
   ```

### Setting Up the Backend (Django)
1. **Navigate to the backend directory:**
   ```bash
   cd csp_back
   ```

2. **Create a virtual environment:**
   ```bash
   python -m venv env
   source env/bin/activate  # On Windows use `env\Scripts\activate`
   ```

3. **Install required packages:**
   ```bash
   pip install -r requirements.txt
   ```

### Connecting PostgreSQL with Django
1. **Configure PostgreSQL:**
   - Create a PostgreSQL database for your project (e.g., `csp_db`).
   - Create a user with access to this database.

2. **Update the database settings in `csp_back/settings.py`:**
   Replace the default database settings with your PostgreSQL configuration:
   ```python
   DATABASES = {
       'default': {
           'ENGINE': 'django.db.backends.postgresql',
           'NAME': 'csp_db',  # Your database name
           'USER': 'your_username',  # Your PostgreSQL username
           'PASSWORD': 'your_password',  # Your PostgreSQL password
           'HOST': 'localhost',  # Set to 'localhost' if running PostgreSQL locally
           'PORT': '',  # Leave blank for default port 5432
       }
   }
   ```

3. **Run database migrations:**
   ```bash
   python manage.py migrate
   ```

4. **Create a superuser for the admin panel:**
   ```bash
   python manage.py createsuperuser
   ```

5. **Start the Django development server:**
   ```bash
   python manage.py runserver
   ```

### Setting Up the Frontend (Flutter)
1. **Navigate to the frontend directory:**
   ```bash
   cd ../csp_front
   ```

2. **Inside `csp_front`, navigate to the citizen app:**
   ```bash
   cd csp_citizen
   ```

3. **Get Flutter dependencies:**
   ```bash
   flutter pub get
   ```

4. **Run the Flutter application for the citizen app:**
   ```bash
   flutter run
   ```

5. **To run the department app, navigate to `csp_dept`:**
   ```bash
   cd ../csp_dept
   flutter pub get
   flutter run
   ```

## Contributing
Contributions are welcome! Please open an issue or submit a pull request for any changes or suggestions.

## Contact
For any questions or feedback, please reach out at [Mohammedmihad2@gmail.com](mailto:Mohammedmihad2@gmail.com
