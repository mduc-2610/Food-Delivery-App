import pickle
import numpy as np
from pathlib import Path
import pandas as pd
from scipy.sparse import csr_matrix
from sklearn.neighbors import NearestNeighbors
import os

class DishRecommender:
    def __init__(self):
        self.model = None
        self.X = None
        self.dish_names = None
        self.dish_names_inv = None
        self.dish_mapper = None
        self.dish_inv_mapper = None
        self.user_mapper = None
        self.user_inv_mapper = None
    
    def find_similar_dishes(self, dish_id=None, dish_name=None, k=5):
        try:
            if dish_id is None and dish_name is None:
                raise ValueError("Must provide either dish_id or dish_name")
            
            if dish_id is None:
                dish_id = self.dish_names_inv.get(dish_name)
                if dish_id is None:
                    raise KeyError(f"Dish name '{dish_name}' not found")
                
            dish_id = str(dish_id)
            dish_ind = self.dish_mapper[dish_id]
            dish_vec = self.X[dish_ind].reshape(1, -1)
            
            neighbor_indices = self.model.kneighbors(dish_vec, 
                                                return_distance=False).flatten()
            
            neighbor_indices = neighbor_indices[1:]
            similar_dishes = []
            for idx in neighbor_indices:
                dish_id = self.dish_inv_mapper[idx]
                dish_name = self.dish_names[dish_id]
                similar_dishes.append((dish_name, dish_id))
            
            return similar_dishes
            
        except Exception as e:
            print(f"Error finding similar dishes: {str(e)}")
            return []
    
    def save(self, filepath):
        data = {
            'model': self.model,
            'X': self.X,
            'dish_names': self.dish_names,
            'dish_names_inv': self.dish_names_inv,
            'dish_mapper': self.dish_mapper,
            'dish_inv_mapper': self.dish_inv_mapper,
            'user_mapper': self.user_mapper,
            'user_inv_mapper': self.user_inv_mapper
        }
        
        os.makedirs(os.path.dirname(filepath), exist_ok=True)
        with open(filepath, 'wb') as f:
            pickle.dump(data, f)
    
    @classmethod
    def load(cls, filepath):
        with open(filepath, 'rb') as f:
            data = pickle.load(f)
        
        recommender = cls()
        recommender.model = data['model']
        recommender.X = data['X']
        recommender.dish_names = data['dish_names']
        recommender.dish_names_inv = data['dish_names_inv']
        recommender.dish_mapper = data['dish_mapper']
        recommender.dish_inv_mapper = data['dish_inv_mapper']
        recommender.user_mapper = data['user_mapper']
        recommender.user_inv_mapper = data['user_inv_mapper']
        
        return recommender