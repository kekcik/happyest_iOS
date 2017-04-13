//
//  MenuManager.swift
//  Happy
//
//  Created by Ivan Trofimov on 14.03.17.
//  Copyright © 2017 Ivan Trofimov. All rights reserved.
//

import Foundation

class MenuManager {
    static let sh = MenuManager() //shared instance
    
    private init() {}
    private var ingredients: [Ingredient] = []
    private var meals: [Meal] = []
    
    func putMeal(meal: Meal){
        meals.append(meal)
    }
    
    func getAllMeals() -> [Meal] {
        return meals
    }
    
    func getMealsFor(category: Int) -> [Meal] {
        var localMeals:[Meal] = []
        for meal in meals {
            if meal.type == category {
                localMeals += [meal]
            }
        }
        return localMeals
    }
    
    func putIngredient(ing: Ingredient) {
        ingredients.append(ing)
    }
    
    func getAllIngredients() -> [Ingredient] {
        return ingredients
    }
}
