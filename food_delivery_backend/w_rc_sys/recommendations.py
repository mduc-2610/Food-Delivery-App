#!/usr/bin/env python
# coding: utf-8

# In[1]:


# Import libraries
import pandas as pd
from pandas import DataFrame
from pathlib import Path
import numpy as np
import seaborn as sns
from scipy.sparse import csr_matrix
from sklearn.neighbors import NearestNeighbors
import ast
import random
from pathlib import Path


# In[2]:


def extract_id(obj):
    try:
        if isinstance(obj, str):
            if not obj.strip().startswith('{'):
                return str(obj)
            _dict = ast.literal_eval(obj)
            return _dict.get('id')
        elif isinstance(obj, dict):
            return obj.get('id')
        return str(obj) if obj is not None else None
    except:
        return None

def convert_object_to_string(df):
    object_columns = df.select_dtypes(include=['object']).columns
    df[object_columns] = df[object_columns].astype('string')
    return df

def process_df(df):
    object_columns = df.select_dtypes(include=['object']).columns
    print(object_columns)
    df[object_columns] = df[object_columns].map(extract_id)
    # df = convert_object_to_string(df)
    return df


# In[ ]:


# import os
# def c_path(path, output_folder="data"):
#     return Path(output_folder, path)

# order_path = c_path('order.csv')
# restaurant_path = c_path('restaurant.csv')
# dish_category = c_path('dish_category.csv')
# dish_review_path = c_path('dish_review.csv')

# user_path = c_path('user.csv')
# profile_path = c_path('profile.csv')
# dish_path = c_path('dish.csv')

import os
from django.conf import settings
def c_path(path, output_folder="data"):
    return Path(output_folder, path)

order_path = os.path.join(settings.BASE_DIR, 'w_rc_sys', 'data','order.csv')
restaurant_path = os.path.join(settings.BASE_DIR, 'w_rc_sys', 'data','restaurant.csv')
dish_category = os.path.join(settings.BASE_DIR, 'w_rc_sys', 'data','dish_category.csv')
dish_review_path = os.path.join(settings.BASE_DIR, 'w_rc_sys', 'data','dish_review.csv')

user_path = os.path.join(settings.BASE_DIR, 'w_rc_sys', 'data','user.csv')
profile_path = os.path.join(settings.BASE_DIR, 'w_rc_sys', 'data','profile.csv')
dish_path = os.path.join(settings.BASE_DIR, 'w_rc_sys', 'data','dish.csv')


# In[4]:


order_df = pd.read_csv(order_path, index_col=0)
order_df = process_df(order_df)

profile_df = pd.read_csv(profile_path, index_col=0)
profile_df = process_df(profile_df)

restaurant_df = pd.read_csv(restaurant_path, index_col=0)
restaurant_df = process_df(restaurant_df)

dish_category_df = pd.read_csv(dish_category, index_col=0)
dish_category_df = process_df(dish_category_df)

dish_review_df = pd.read_csv(dish_review_path, index_col=0)
dish_review_df = process_df(dish_review_df)

user_df = pd.read_csv(user_path, index_col=0)
user_df = process_df(user_df)

dish_df = pd.read_csv(dish_path, index_col=0)
dish_df = process_df(dish_df)


# In[5]:


dish_review_df = process_df(dish_review_df)
dish_review_df


# In[6]:


dish_review_df.head()


# In[7]:


dish_df = pd.read_csv(dish_path, index_col=0)
dish_df.drop(dish_df.iloc[:, 7:], inplace=True, axis=1)
dish_df.drop(columns=['image', 'description', 'rating', 'category'], inplace=True)
dish_df.head()


# In[8]:


# user_df = pd.read_csv(user_path, index_col=0)
# profile_df = pd.read_csv(profile_path, index_col=0)


# user_df = pd.merge(user_df, profile_df, left_on='id', right_on='user')

# try:
#     user_df.drop(columns=[
#         'deliverer',
#         'restaurant',
#         'is_active',
#         'is_staff',
#         'is_certified_deliverer', 
#         'is_certified_restaurant', 
#         'selected_location',
#     ], inplace=True)
# except:
#     print("Columns specified do not exist")

user_df.head()


# In[9]:


user_dish_review_df = pd.merge(user_df, dish_review_df, left_on='id', right_on='user')


# In[10]:


user_dish_review_df.head()


# In[11]:


dish_user_review_df = pd.merge(user_dish_review_df, dish_df, left_on='dish', right_on='id')


# In[12]:


dish_user_review_df.rename(columns={'name_x': 'user_name', 'name_y': 'dish_name'}, inplace=True)
dish_user_review_df.drop(columns=[
    # 'user_name', 
    # 'dish_name',
    # 'user', 
    # 'order', 
    # 'dish',
    # 'rating', 
    'phone_number', 
    'avatar', 
    'title',
    'content', 
    'created_at', 
    'updated_at', 
    'total_likes',
    'total_replies',
    'is_liked',
    'images',
    'replies',
    'original_price',
    'discount_price'
], inplace=True)


# In[13]:


dish_user_review_df.info()


# In[14]:


dish_user_review_df.shape


# In[15]:


user_df.head()


# In[16]:


from scipy.sparse import csr_matrix

def create_matrix(df):
    N = len(df['user'].unique())
    M = len(df['dish'].unique())
      
    user_mapper = dict(zip(np.unique(df["user"]), list(range(N))))
    dish_mapper = dict(zip(np.unique(df["dish"]), list(range(M))))
      
    user_inv_mapper = dict(zip(list(range(N)), np.unique(df["user"])))
    dish_inv_mapper = dict(zip(list(range(M)), np.unique(df["dish"])))
      
    user_index = [user_mapper[i] for i in df['user']]
    dish_index = [dish_mapper[i] for i in df['dish']]
  
    X = csr_matrix((df["rating"].values, (dish_index, user_index)), 
                    shape=(M, N))      
    return X, user_mapper, dish_mapper, user_inv_mapper, dish_inv_mapper


# In[17]:


X, user_mapper, dish_mapper, user_inv_mapper, dish_inv_mapper = create_matrix(dish_user_review_df)


# # K-Nearest Neighbors
# 
# Sci-kit Learn's NearestNeighbors algorithm is an unsupervised learner for implementing neighbor searches. Here we will execute a brute search with a cosine similarity matrix where the algorithm normalizes the rating by subtracting the mean.

# In[19]:


from sklearn.neighbors import NearestNeighbors

model = NearestNeighbors(n_neighbors=5, algorithm="brute", metric='cosine')
model.fit(X)


# In[20]:


dish_names = dict(zip(dish_user_review_df['dish'], dish_user_review_df['dish_name']))
# dish_names


# In[21]:


dish_names_inv = {v: k for k, v in dish_names.items()}
# dish_mapper
dish_names
# len(dish_names_inv)


# In[22]:


dish_user_review_df.loc[dish_user_review_df['dish_name']  ==  'Cookie thank particularly']


# In[39]:


def find_similar_dishes(dish_id=None, dish_name=None, k=5):
    try:
        if dish_id is None and dish_name is None:
            raise ValueError("Must provide either dish_id or dish_name")
        
        if dish_id is None:
            dish_id = dish_names_inv.get(dish_name)
            if dish_id is None:
                raise KeyError(f"Dish name '{dish_name}' not found")
            
        dish_id = str(dish_id)
        dish_ind = dish_mapper[dish_id]
        dish_vec = X[dish_ind].reshape(1, -1)
        
        neighbor_indices = model.kneighbors(dish_vec, 
                                            return_distance=False).flatten()
        
        neighbor_indices = neighbor_indices[1:]
        similar_dishes = []

        print(f"Since you eat ----- {dish_name if dish_name else dish_names[dish_id]} -- {dish_id}:")

        for idx in neighbor_indices:
            dish_id = dish_inv_mapper[idx]
            dish_name = dish_names[dish_id]
            similar_dishes.append((dish_name, dish_id))
        
        return similar_dishes
        
    except Exception as e:
        print(f"Error finding similar dishes: {str(e)}")
        return []


# In[53]:


import random

name_ = random.choice(list(dish_names_inv.keys()))
find_similar_dishes(dish_name=name_)

