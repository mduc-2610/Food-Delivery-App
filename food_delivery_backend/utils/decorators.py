import functools
from typing import Callable, List, Optional, Dict, Any
from django.db.models import Model

class MapQuerySet:
    def __init__(self, _dict=None):
        self._objects = {} if not _dict else _dict.copy()

    def get(self, model, default=None):
        if model not in self._objects:
            self._objects[model] = default if default is not None else model.objects.all()
        return self._objects[model]

    def __len__(self):
        return len(self._objects)

    def clear(self):
        self._objects.clear()

def get_models_to_update(model_map, models_to_update=None):
    if not models_to_update:
        return list(model_map.values())
    return [model_map[m] for m in models_to_update if m in model_map]

def delete_models(models_to_delete):
    for model in models_to_delete:
        model.objects.all().delete()

def script_runner(model_map):
    def decorator(func):
        @functools.wraps(func)
        def wrapper(*args):
            action = 'delete'
            if len(args) >= 1: action = args[0]
            models_to_update = list(args[1:])
            
            if action == 'delete':
                models_to_delete = models_to_update.copy() if models_to_update else model_map.keys()
                delete_models([model_map[m] for m in models_to_delete if m in model_map])
            
            models_to_update_classes = get_models_to_update(model_map, models_to_update)

            func(
                models_to_update=models_to_update_classes,
                map_queryset=MapQuerySet(),
                action=action,
            )
    
        return wrapper
    
    return decorator