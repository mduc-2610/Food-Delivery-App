#!/usr/bin/env python
# coding: utf-8

# In[1]:


import requests
import csv
from pathlib import Path
import ast
import random


# In[2]:


base_url = "http://127.0.0.1:8000/api/";

def c_path(path, output_folder="data"):
    return Path(output_folder, path)

def fetch_and_store_orders(endpoint, output_file, query_params=None):
    try:
        api_url = f"{base_url}{endpoint}/?{query_params}&can_paginate=False"
        response = requests.get(api_url)
        response.raise_for_status()  
        data = response.json()  
        print(data)

        if not isinstance(data, list):
            print("Unexpected API response format.")
            return

        if len(data) > 0:
            columns = data[0].keys()
        else:
            print("No records found.")
            return

        with open(output_file, mode="w", newline="", encoding="utf-8") as csv_file:
            writer = csv.DictWriter(csv_file, fieldnames=columns)
            writer.writeheader()  
            writer.writerows(data)  

        print(f"Data successfully written to {output_file}.")

    except requests.exceptions.RequestException as e:
        print(f"Error fetching data: {e}")
    except Exception as e:
        print(f"An error occurred: {e}")


# In[3]:


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


# In[4]:


user_path = c_path('user.csv')
profile_path = c_path('profile.csv')
order_path = c_path('order.csv')
dish_review_path = c_path('dish_review.csv')
restaurant_path = c_path('restaurant.csv')
dish_path = c_path('dish.csv')
dish_category_path = c_path('dish_category.csv')


# In[5]:


order_endpoint = "order/order"
fetch_and_store_orders(order_endpoint, order_path, query_params="status=COMPLETED")


# In[6]:


dish_review_endpoint = "review/dish-review"
fetch_and_store_orders(dish_review_endpoint, dish_review_path)


# In[7]:


user_endpoint = "account/user"
fetch_and_store_orders(user_endpoint, user_path, query_params="basic=1")


# In[8]:


profile_endpoint = "account/profile"
fetch_and_store_orders(profile_endpoint, profile_path)


# In[9]:


restaurant_endpoint = "restaurant/restaurant"
fetch_and_store_orders(restaurant_endpoint, restaurant_path)


# In[10]:


dish_endpoint = "food/dish"
fetch_and_store_orders(dish_endpoint, dish_path)


# In[11]:


dish_category_endpoint = "food/dish-category"
fetch_and_store_orders(dish_category_endpoint, dish_category_path)


# In[12]:


import pandas as pd
from pathlib import Path


order_df = pd.read_csv(order_path, index_col=0)
order_df

dish_df = pd.read_csv(dish_path, index_col=0)

# dish_review = pd.read_csv(dish_review_path, index_col=0)
# dish_review


# In[13]:


dish_review_df = pd.read_csv(dish_review_path, index_col=0)
dish_review_df = process_df(dish_review_df)

user_df = pd.read_csv(user_path, index_col=0)
user_df = process_df(user_df)

dish_df = pd.read_csv(dish_path, index_col=0)
dish_df = process_df(dish_df)


# In[14]:


dish_review_df.head()


# In[15]:


user_df.head()


# In[16]:


dish_df.head()

