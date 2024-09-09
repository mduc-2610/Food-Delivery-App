import math
from django.db import models
from django.db.models import F

class Point:
    def __init__(self, *args):
        if len(args) >= 2:
            self.latitude = args[0]
            self.longitude = args[1]
        else:
            raise ValueError("Insufficient arguments provided for Point initialization. Latitude and longitude are required.")

    def __str__(self):
        return f"Point({self.latitude}, {self.longitude})"

class Distance:
    @staticmethod
    def haversine(point1, point2):
        R = 6371.0

        latitude1 = math.radians(point1.latitude)
        longitude1 = math.radians(point1.longitude)
        latitude2 = math.radians(point2.latitude)
        longitude2 = math.radians(point2.longitude)

        dlat = latitude2 - latitude1
        dlon = longitude2 - longitude1

        a = math.sin(dlat / 2) ** 2 + math.cos(latitude1) * math.cos(latitude2) * math.sin(dlon / 2) ** 2
        c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))

        return R * c
