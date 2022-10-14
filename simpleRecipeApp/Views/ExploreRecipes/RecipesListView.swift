//
//  ContentView.swift
//  simpleRecipeApp
//
//  Created by cecily li on 8/28/22.
//

import SwiftUI

struct RecipesListView: View {
    //creates an instance of RecipeData
    //the current view and any children views can access that object.
    @EnvironmentObject private var recipeData: RecipeData
    let viewStyle: ViewStyle
    //tracks if the modal view is currently being presented.
    @State private var isPresenting = false
    @State private var newRecipe = Recipe()
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
//        NavigationView {
            List {
                ForEach(recipes) { recipe in
                    NavigationLink(recipe.mainInformation.name, destination: RecipeDetailView(recipe: binding(for: recipe)))
                }
                .listRowBackground(listBackgroundColor)
                .foregroundColor(listTextColor)
            }
            .navigationTitle(navigationTitle)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresenting = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            })
            .sheet(isPresented: $isPresenting, content: {
                NavigationView {
                    ModifyRecipeView(recipe: $newRecipe)
                        .toolbar(content: {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Dismiss") {
                                    isPresenting = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                if newRecipe.isValid {
                                    Button("Add") {
                                        recipeData.add(recipe: newRecipe)
                                        isPresenting = false
                                    }
                                }
                            }
                        })
                        .navigationTitle("Add new recipe")
                }
            })
        }
    }
//}
extension RecipesListView {
    enum ViewStyle {
        case favorites
        case singleCategory(MainInformation.Category)
    }
    private var recipes: [Recipe] {
        switch viewStyle {
            case let .singleCategory(category):
              return recipeData.recipes(for: category)
            case .favorites:
              return recipeData.favoriteRecipes
            }
    }
    
    private var navigationTitle: String {
        switch viewStyle {
            case let .singleCategory(category):
              return "\(category.rawValue) Recipes"
            case .favorites:
              return "Favorite Recipes"
            }
    }
    
    func binding(for recipe: Recipe) -> Binding<Recipe> {
        guard let index = recipeData.index(of: recipe) else {
            fatalError("Recipe not found")
        }
        return $recipeData.recipes[index]
    }
}

struct RecipesListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecipesListView(viewStyle: .singleCategory(.breakfast) )
        }.environmentObject(RecipeData())
    }
}
