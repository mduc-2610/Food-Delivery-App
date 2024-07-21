import random

def load_intermediate_model(
        model_class, 
        primary_field, related_field, 
        primary_objects, related_objects, 
        max_items,
        attributes={}
    ):
    created_objects = []
    
    if type(primary_objects) is not list:
        primary_objects = list(primary_objects)
    if type(related_objects) is not list:
        related_objects = list(related_objects)

    for primary_obj in primary_objects:
        temp_related_objects = related_objects.copy()
        for _ in range(random.randint(1, max(max_items, 1))):
            if not temp_related_objects:
                break
            related_obj = temp_related_objects.pop(random.randint(0, len(temp_related_objects) - 1))
            data = {
                primary_field: primary_obj,
                related_field: related_obj,
                **{attr: value() if callable(value) else value for attr, value in attributes.items()}
            }
            created_object = model_class.objects.create(**data)
            created_objects.append(created_object)
            print(f"\tSuccessfully created {model_class.__name__}: {created_object}")
    return created_objects

