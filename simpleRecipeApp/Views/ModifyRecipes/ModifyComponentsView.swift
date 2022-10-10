//
//  ModifyComponentsView.swift
//  simpleRecipeApp
//
//  Created by cecily li on 10/6/22.
//

import SwiftUI
//create a recipecomponent protocol and have ingredient and direction conform to it.
protocol RecipeComponent: CustomStringConvertible {
    init()
    static func singularName() -> String
    static func pluralName() -> String
}

protocol ModifyComponentView: View {
    //correlate to specific component(ingredients or directions)
    associatedtype Component
    init(component: Binding<Component>, createAction: @escaping(Component) -> Void)
}

struct ModifyComponentsView<Component: RecipeComponent, DestinationView: ModifyComponentView>: View where DestinationView.Component == Component  {
    @Binding var components: [Component]
    @State private var newComponent = Component()
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        VStack {
            let addComponentView = DestinationView(component: $newComponent) { component in
                components.append(component)
                newComponent = Component()
            }.navigationTitle("Add \(Component.singularName().capitalized)")
            if components.isEmpty {
                Spacer()
                NavigationLink("Add the first \(Component.singularName())",
                               destination: addComponentView)
                Spacer()
            } else {
                HStack {
                    Text(Component.pluralName().capitalized)
                        .font(.title)
                        .padding()
                    Spacer()
                }
                List {
                    ForEach(components.indices, id: \.self) { index in
                        let component = components[index]
                        Text(component.description)
                    }
                    .listRowBackground(listBackgroundColor)
                    NavigationLink("Add another \(Component.singularName())",
                                   destination: addComponentView)
                    .buttonStyle(PlainButtonStyle())
                    .listRowBackground(listBackgroundColor)
                }.foregroundColor(listTextColor)
            }
        }
    }
}

extension RecipeComponent {
    static func singularName() -> String {
        String(describing: self).lowercased()
    }
    static func pluralName() -> String {
        self.singularName() + "s"
    }
}

struct ModifyComponentsView_Previews: PreviewProvider {
    @State static var emptyIngredients = [Ingredient]()
    @State static var recipe = Recipe.testRecipes[1]
    static var previews: some View {
        NavigationView {
             ModifyComponentsView<Ingredient, ModifyIngredientView>(components: $recipe.ingredients)
           }
         }
}
