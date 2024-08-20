dish_categories = [
    {"name": "Burger", "image": "burger.png"},
    {"name": "Taco", "image": "taco.png"},
    {"name": "Burrito", "image": "burrito.png"},
    {"name": "Drink", "image": "drink.png"},
    {"name": "Pizza", "image": "pizza.png"},
    {"name": "Donut", "image": "donut.png"},
    {"name": "Salad", "image": "salad.png"},
    {"name": "Pho", "image": "pho.png"},
    {"name": "Sandwich", "image": "sandwich.png"},
    {"name": "Pasta", "image": "pasta.png"},
    {"name": "Ice Cream", "image": "icecream.png"},
    {"name": "Rice", "image": "rice.png"},
    {"name": "Takoyaki", "image": "takoyaki.png"},
    {"name": "Fruit", "image": "fruit.png"},
    {"name": "Hot Dog", "image": "hot_dog.png"},
    {"name": "Goi Cuon", "image": "goicuon.png"},
    {"name": "Cookie", "image": "cookie.png"},
    {"name": "Pudding", "image": "pudding.png"},
    {"name": "Banh Mi", "image": "banhmi.png"},
    {"name": "Dumpling", "image": "dumpling.png"},
]

category_options = {
    "Banh Mi": {
        "toppings": ["Extra Meat", "Pickled Vegetables", "Fried Egg"],
        "sauces": ["Sriracha", "Mayo", "Soy Sauce"],
        "sizes": ["Small", "Medium", "Large"]
    },
    "Burger": {
        "toppings": ["Cheese", "Bacon", "Lettuce", "Tomato", "Onion", "Pickles"],
        "sauces": ["Ketchup", "Mustard", "BBQ Sauce", "Mayo"],
        "sizes": ["Single", "Double", "Triple"],
        "extras": ["Extra Patty", "Avocado", "Fried Egg"]
    },
    "Pho": {
        "toppings": ["Extra Beef", "Extra Noodles", "Extra Veggies", "Tofu"],
        "sauces": ["Hoison", "Sriracha", "Fish Sauce"],
        "sizes": ["Small", "Regular", "Large", "XL"],
        "sugar_options": ["50% Sugar", "100% Sugar"],
        "broth_type": ["Beef", "Chicken", "Vegetarian"]
    },
    "Pizza": {
        "toppings": ["Pepperoni", "Mushrooms", "Olives", "Onions", "Bell Peppers"],
        "sizes": ["Small", "Medium", "Large", "Family"],
        "crust": ["Thin Crust", "Thick Crust", "Stuffed Crust", "Gluten-Free"],
        "sauces": ["Tomato Sauce", "White Sauce", "Pesto", "BBQ Sauce"]
    },
    "Taco": {
        "toppings": ["Cheese", "Lettuce", "Sour Cream", "Guacamole", "Pico de Gallo"],
        "shell_type": ["Hard Shell", "Soft Shell", "Lettuce Wrap"],
        "sizes": ["Single", "Double", "Triple"],
        "sauces": ["Salsa", "Hot Sauce", "Lime Crema"],
        "extras": ["Extra Meat", "Extra Cheese", "Avocado"]
    },
    "Ice Cream": {
        "toppings": ["Sprinkles", "Chocolate Chips", "Whipped Cream", "Cherries"],
        "sizes": ["Small", "Medium", "Large"],
        "flavors": ["Vanilla", "Chocolate", "Strawberry", "Mint Chocolate Chip"],
        "sauces": ["Hot Fudge", "Caramel", "Strawberry Syrup"]
    },
    "Hot Dog": {
        "toppings": ["Ketchup", "Mustard", "Relish", "Onions", "Sauerkraut"],
        "sizes": ["Regular", "Footlong"],
        "extras": ["Extra Sausage", "Chili", "Cheese", "Bacon"],
        "buns": ["Regular", "Whole Wheat", "Gluten-Free"]
    },
    "Rice": {
        "toppings": ["Fried Egg", "Green Onions", "Sesame Seeds", "Nori"],
        "sizes": ["Small", "Regular", "Large"],
        "sauces": ["Soy Sauce", "Teriyaki", "Sriracha", "Fish Sauce"],
        "extras": ["Extra Rice", "Extra Meat", "Tofu"]
    },
    "Pasta": {
        "toppings": ["Parmesan Cheese", "Red Pepper Flakes", "Basil"],
        "sauces": ["Marinara", "Alfredo", "Pesto", "Carbonara"],
        "sizes": ["Small", "Regular", "Large"],
        "pasta_type": ["Spaghetti", "Fettuccine", "Penne", "Rigatoni"],
        "extras": ["Meatballs", "Grilled Chicken", "Shrimp"]
    },
    "Donut": {
        "toppings": ["Sprinkles", "Chocolate Chips", "Coconut Flakes", "Nuts"],
        "sizes": ["Small", "Regular", "Large"],
        "glazes": ["Chocolate", "Vanilla", "Maple", "Strawberry"],
        "fillings": ["Cream", "Jelly", "Custard", "Chocolate"]
    },
    "Drink": {
        "sizes": ["Small", "Medium", "Large"],
        "sugar_options": ["50% Sugar", "100% Sugar", "No Sugar"],
        "ice_options": ["No Ice", "Less Ice", "Regular Ice", "Extra Ice"],
        "flavors": ["Lemon", "Peach", "Mango", "Lychee"]
    },
    "Takoyaki": {
        "toppings": ["Bonito Flakes", "Green Onions", "Pickled Ginger"],
        "sizes": ["6 Pieces", "9 Pieces", "12 Pieces"],
        "sauces": ["Takoyaki Sauce", "Mayo", "Sriracha"],
        "fillings": ["Octopus", "Shrimp", "Cheese"]
    },
    "Pudding": {
        "toppings": ["Whipped Cream", "Fruit", "Chocolate Shavings"],
        "sizes": ["Small", "Medium", "Large"],
        "flavors": ["Vanilla", "Chocolate", "Butterscotch", "Rice"],
        "extras": ["Extra Pudding", "Caramel Sauce", "Fresh Berries"]
    },
    "Dumpling": {
        "toppings": ["Sesame Seeds", "Green Onions", "Crispy Garlic"],
        "sizes": ["6 Pieces", "9 Pieces", "12 Pieces"],
        "fillings": ["Pork", "Chicken", "Vegetarian", "Shrimp"],
        "sauces": ["Soy Sauce", "Chili Oil", "Vinegar", "Garlic Sauce"]
    },
    "Burrito": {
        "toppings": ["Cheese", "Sour Cream", "Guacamole", "Lettuce", "Pico de Gallo"],
        "sizes": ["Regular", "Large", "XL"],
        "extras": ["Extra Meat", "Extra Rice", "Extra Beans"],
        "sauces": ["Salsa", "Hot Sauce", "Chipotle Mayo"]
    },
    "Goi Cuon": {
        "toppings": ["Shrimp", "Pork", "Tofu", "Mint", "Lettuce"],
        "sizes": ["2 Rolls", "4 Rolls", "6 Rolls"],
        "sauces": ["Peanut Sauce", "Hoisin Sauce", "Fish Sauce"]
    },
    "Cookie": {
        "toppings": ["Chocolate Chips", "Nuts", "Sprinkles"],
        "sizes": ["Small", "Medium", "Large"],
        "flavors": ["Chocolate Chip", "Oatmeal Raisin", "Sugar", "Peanut Butter"],
        "fillings": ["Nutella", "Peanut Butter", "Jam"]
    },
    "Fruit": {
        "sizes": ["Small", "Medium", "Large"],
        "varieties": ["Apple", "Banana", "Orange", "Mango", "Strawberry"],
        "extras": ["Whipped Cream", "Yogurt", "Honey", "Granola"]
    },
    "Sandwich": {
        "toppings": ["Cheese", "Lettuce", "Tomato", "Onion", "Pickles"],
        "sauces": ["Mayo", "Mustard", "Chipotle Mayo", "BBQ Sauce"],
        "sizes": ["6 Inch", "12 Inch"],
        "extras": ["Extra Meat", "Avocado", "Bacon"]
    },
    "Rice Bowl": {
        "toppings": ["Sesame Seeds", "Green Onions", "Pickled Veggies", "Nori"],
        "sizes": ["Small", "Medium", "Large"],
        "extras": ["Extra Rice", "Extra Meat", "Fried Egg"],
        "sauces": ["Soy Sauce", "Teriyaki", "Sriracha"]
    },
    "Takoyaki": {
        "toppings": ["Bonito Flakes", "Green Onions", "Pickled Ginger"],
        "sizes": ["6 Pieces", "9 Pieces", "12 Pieces"],
        "sauces": ["Takoyaki Sauce", "Mayo", "Sriracha"],
        "fillings": ["Octopus", "Shrimp", "Cheese"]
    },
    "Taco": {
        "toppings": ["Cheese", "Lettuce", "Sour Cream", "Guacamole", "Pico de Gallo"],
        "shell_type": ["Hard Shell", "Soft Shell", "Lettuce Wrap"],
        "sizes": ["Single", "Double", "Triple"],
        "sauces": ["Salsa", "Hot Sauce", "Lime Crema"],
        "extras": ["Extra Meat", "Extra Cheese", "Avocado"]
    },
    "Hot Dog": {
        "toppings": ["Ketchup", "Mustard", "Relish", "Onions", "Sauerkraut"],
        "sizes": ["Regular", "Footlong"],
        "extras": ["Extra Sausage", "Chili", "Cheese", "Bacon"],
        "buns": ["Regular", "Whole Wheat", "Gluten-Free"]
    }
}
