//
//  ModifyIngredientView.swift
//  simpleRecipeApp
//
//  Created by cecily li on 10/6/22.
//

import SwiftUI

struct ModifyIngredientView: View {
    @Binding var ingredient: Ingredient
    //createAction closure take an ingredient and return void
    let createAction:((Ingredient) -> Void)
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    @Environment(\.presentationMode) private var mode
    
    var body: some View {
            Form {
                TextField("Ingredient Name", text: $ingredient.name)
                Stepper(value: $ingredient.quantity, in: 0...100, step: 0.5) {
                    HStack {
                        Text("Quantity:")
                        TextField("Quantity",
                                  value: $ingredient.quantity,
                                  formatter: NumberFormatter.decimal)
                        .keyboardType(.numbersAndPunctuation)
                    }
                }.listRowBackground(listBackgroundColor)
                Picker(selection: $ingredient.unit, label: HStack {
                    Text("Unit")
                    Spacer()
                    Text(ingredient.unit.rawValue)
                }) {
                    ForEach(Ingredient.Unit.allCases, id: \.self) {
                        unit in Text(unit.rawValue)
                    }
                }
                .listRowBackground(listBackgroundColor)
                .pickerStyle(MenuPickerStyle())
                HStack {
                    Spacer()
                    Button("Save") {
                        createAction(ingredient)
                        mode.wrappedValue.dismiss()
                    }
                    Spacer()
                }.listRowBackground(listBackgroundColor)
            }
            .foregroundColor(listTextColor)
        }
    }

extension NumberFormatter {
    static var decimal: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }
}

struct ModifyIngredientView_Previews: PreviewProvider {
    @State static var emptyIngredient = Ingredient()
    static var previews: some View {
        ModifyIngredientView(ingredient: $emptyIngredient) { ingredient in
            print(ingredient)}
    }
}
