//
//  RecipeData.swift
//  simpleRecipeApp
//
//  Created by cecily li on 8/29/22.
//

import Foundation

class RecipeData: ObservableObject {
    //ObservableObject protocol monitors when the @Published property changes.
    @Published var recipes = Recipe.testRecipes
    func recipes(for category: MainInformation.Category) -> [Recipe] {
        var filteredRecipes = [Recipe]()
        for recipe in recipes {
            if recipe.mainInformation.category == category {
                filteredRecipes.append(recipe)
            }
        }
        return filteredRecipes
    }
    
    func add(recipe: Recipe) {
        if recipe.isValid {
            recipes.append(recipe)
        }
    }
}
