//
//  RecipeCategoryGridView.swift
//  simpleRecipeApp
//
//  Created by cecily li on 8/29/22.
//

import SwiftUI

struct RecipeCategoryGridView: View {
    //since maintabview will be initial view, RecipeCategoryGridView should have recipedata passed in. instead of creating its own.
    @EnvironmentObject  private var recipeData: RecipeData
    var body: some View {
        let columns = [GridItem(), GridItem()]
        NavigationView {
            ScrollView {
            LazyVGrid(columns: columns, content: {
                ForEach(MainInformation.Category.allCases,
                        id: \.self) {
                    category in
                    NavigationLink(
                        destination:
                            RecipesListView(viewStyle: .singleCategory(category))
                            .environmentObject(recipeData),
                        label: {CategoryView(category: category)
                })
                }
            })
        }
            .navigationTitle("Categories")
        }
    }
}

struct CategoryView: View {
    let category: MainInformation.Category
    
    var body: some View {
        ZStack {
            Image(category.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.35)
            Text(category.rawValue)
                .font(.title)
        }
    }
}

struct RecipeCategoryGridView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCategoryGridView()
    }
}
