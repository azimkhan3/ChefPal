import csv
import json

def make_json():
    ingredients = {}

    with open('ingredients.csv') as f:
        reader = csv.DictReader(f)
        for row in reader:
            pair = row['ingredient;ingredientId'].split(';')
            ingredients[pair[1]] = pair[0]
    
    with open('ingredients.json', 'w') as f:
        f.write(json.dumps(ingredients))

if __name__ == "__main__":
    make_json()