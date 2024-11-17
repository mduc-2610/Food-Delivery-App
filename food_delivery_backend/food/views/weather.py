import requests
from rest_framework import views
from rest_framework.response import Response

class WeatherView(views.APIView):
    def get(self, request, *args, **kwargs):
        city = request.query_params.get('q')
        zip_code = request.query_params.get('zip')
        lat = request.query_params.get('lat')
        lon = request.query_params.get('lon')
        
        api_key = '46518dbdb84d55ff7cace213a59c51f3'
        url = f'http://api.openweathermap.org/data/2.5/weather?units=metric&appid={api_key}'
        if city:
            url += f'&q={city}'
        elif zip_code:
            url += f'&zip={zip_code}'
        elif lat and lon:
            url += f'&lat={lat}&lon={lon}'
        else:
            return Response({"error": "Please provide city, zip, or lat/lon coordinates."}, status=400)

        response = requests.get(url)
        if response.status_code != 200:
            return Response({"error": "Failed to fetch weather data. Please check your inputs."}, status=response.status_code)
        
        weather_data = response.json()
        
        temperature = weather_data['main']['temp']
        weather_description = weather_data['weather'][0]['description']
        humidity = weather_data['main']['humidity']
        
        data = {
            'temperature': temperature,
            'weather_description': weather_description,
            'humidity': humidity,
        }
        
        return Response(data)
