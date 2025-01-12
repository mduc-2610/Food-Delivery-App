# 🍽️ Food Delivery App

A modern food delivery application built with Django REST Framework and Flutter, featuring intelligent food recommendations using collaborative filtering.

## ✨ Features

- 🔐 User authentication and authorization
- 🏪 Restaurant and Shipper management
- 🚚 Real-time order tracking
- 🎯 Smart food recommendations using collaborative filtering

## 🛠️ Technology Stack

### Backend
- 🐍 Django REST Framework
- 🐍 Python (Collaborative Filtering)
- 🗄️ MySQL
- 🔑 JWT Authentication

### Frontend (Mobile)
- 📱 Flutter
- 🎯 Dart
- ⚡ Get State Management
- 🔌 RESTful API Integration

## 🚀 Setup Instructions

### Backend Setup

1. Clone the repository
```bash
git clone <url>
```

2. Create and activate virtual environment
```bash
python -m venv venv
source venv/bin/activate  # For Unix
# or
venv\Scripts\activate     # For Windows
```

3. Install dependencies
```bash
pip install -r requirements.txt
```

4. Configure environment variables
```bash
cp .env.example .env
# Update .env with your configurations
```

5. Run migrations
```bash
python manage.py migrate
```

6. Start the server
```bash
python manage.py runserver
```

### Frontend Setup

1. Navigate to Flutter project
```bash
cd food-delivery-app/frontend
```

2. Get Flutter dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

## 🤖 Recommendation System

The app implements collaborative filtering to provide personalized food recommendations to users based on:
- 📊 Previous order history
- 👤 User preferences
- 👥 Similar users' choices
- ⭐ Rating patterns
