//
//  MainTabView.swift
//  simpleRecipeApp
//
//  Created by cecily li on 10/13/22.
//

import SwiftUI

struct MainTabView: View {
    //initial view
    @StateObject var recipeData = RecipeData()
    var body: some View {
        TabView {
            RecipeCategoryGridView()
                .tabItem { Label("Recipes", systemImage: "list.dash") }
            NavigationView {
                RecipesListView(viewStyle: .favorites)
            }.tabItem {
                Label("Favorites", systemImage: "heart.fill")
            }
        }.environmentObject(recipeData)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
