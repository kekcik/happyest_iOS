//
//  MenuManager.swift
//  Happy
//
//  Created by Ivan Trofimov on 14.03.17.
//  Copyright © 2017 Ivan Trofimov. All rights reserved.
//

import Foundation

class MenuManager {
    private static var ingredients: [Ingredient] = []
    private static var meals: [Meal] = []
    
    static func putMeal(meal: Meal){
        meals.append(meal)
    }
    
    static func getAllMeals() -> [Meal] {
        return meals
    }
    
    static func getMealsFor(category: Int) -> [Meal] {
        var localMeals:[Meal] = []
        for meal in meals {
            if meal.type == category {
                localMeals += [meal]
            }
        }
        return localMeals
    }
    
    static func putIngredient(ing: Ingredient) {
        ingredients.append(ing)
    }
    
    static func getAllIngredients() -> [Ingredient] {
        return ingredients
    }
}
