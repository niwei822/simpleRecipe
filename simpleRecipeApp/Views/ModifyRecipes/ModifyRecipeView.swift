//
//  ModifyRecipeView.swift
//  simpleRecipeApp
//
//  Created by cecily li on 8/30/22.
//

import SwiftUI

struct ModifyRecipeView: View {
    //to access&modify original property, no need to send any recipe data back to recipeslistview.
    @Binding var recipe: Recipe
    @State private var selection = Selection.main
    var body: some View {
        VStack {
            Picker("Select recipe component", selection: $selection) {
                Text("Main Info").tag(Selection.main)
                Text("Ingredients").tag(Selection.ingredients)
                Text("Directions").tag(Selection.directions)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            switch selection {
            case .main:
                Text("Main Editor")
            case .ingredients:
                Text("Ingredients Editor")
            case .directions:
                Text("Directions Editor")
            }
            Spacer()
        }
    }
    enum Selection {
        case main
        case ingredients
        case directions
    }
}

struct ModifyRecipeView_Previews: PreviewProvider {
    @State static var recipe = Recipe()
    static var previews: some View {
        ModifyRecipeView(recipe: $recipe)
    }
}
