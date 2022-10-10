//
//  ModifyComponentsView.swift
//  simpleRecipeApp
//
//  Created by cecily li on 10/6/22.
//

import SwiftUI
//create a recipecomponent protocol and have ingredient and direction conform to it.
protocol RecipeComponent {
    init()
}

protocol ModifyComponentView: View {
    //correlate to specific component(ingredients or directions)
    associatedtype Component
    init(component: Binding<Component>, createAction: @escaping(Component) -> Void)
}

struct ModifyComponentsView: View {
    @Binding var ingredients: [Ingredient]
    @State private var newIngredient = Ingredient()
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        VStack {
            let addIngredientView = ModifyIngredientView(ingredient: $newIngredient) { ingredient in
                ingredients.append(ingredient)
                newIngredient = Ingredient()
            }.navigationTitle("Add Ingredient")
            if ingredients.isEmpty {
                Spacer()
                NavigationLink("Add the first ingredient",
                               destination: addIngredientView)
                Spacer()
            } else {
                List {
                    ForEach(ingredients.indices, id: \.self) { index in
                        let ingredient = ingredients[index]
                        Text(ingredient.description)
                    }
                    .listRowBackground(listBackgroundColor)
                    NavigationLink("Add another ingredient",
                                   destination: addIngredientView)
                    .buttonStyle(PlainButtonStyle())
                    .listRowBackground(listBackgroundColor)
                }.foregroundColor(listTextColor)
            }
        }
    }
}

struct ModifyComponentsView_Previews: PreviewProvider {
    @State static var emptyIngredients = [Ingredient]()
    static var previews: some View {
        ModifyComponentsView(ingredients: $emptyIngredients)
    }
}
