import os
import pickle
from pathlib import Path

from django.core.management.base import BaseCommand
from django.conf import settings

import w_rc_sys.recommendations_test as rec 
from utils.recommender import DishRecommender

class Command(BaseCommand):
    help = 'Trains and saves the dish recommendation model'

    def handle(self, *args, **options):
        self.stdout.write('Training recommendation model...')

        save_path = Path(settings.BASE_DIR) / 'w_rc_sys' / 'ml_models' / 'dish_recommender.pkl'
        def _save(filepath):
            data = {
                'model': rec.model,
                'X': rec.X,
                'dish_names': rec.dish_names,
                'dish_names_inv': rec.dish_names_inv,
                'dish_mapper': rec.dish_mapper,
                'dish_inv_mapper': rec.dish_inv_mapper,
                'user_mapper': rec.user_mapper,
                'user_inv_mapper': rec.user_inv_mapper
            }
            
            os.makedirs(os.path.dirname(filepath), exist_ok=True)
            with open(filepath, 'wb') as f:
                pickle.dump(data, f)
        _save(save_path)
        self.stdout.write(self.style.SUCCESS('Successfully trained model'))