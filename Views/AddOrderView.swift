//
//  AddOrderView.swift
//  TimHortonsRun
//
//  Created by Fatom on 2025-09-17.
//

import SwiftUI

struct AddOrderView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: OrderViewModel
    
    @State private var name = ""
    @State private var drink = "Coffee"
    @State private var size = "Medium"
    @State private var extras = ""
    
    let drinkOptions = ["Coffee", "Latte", "Iced Capp", "Donut", "Bagel"]
    let sizeOptions = ["Small", "Medium", "Large"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Name")) {
                    TextField("Enter name", text: $name)
                }
                Section(header: Text("Drink")) {
                    Picker("Drink", selection: $drink) {
                        ForEach(drinkOptions, id: \.self) { Text($0) }
                    }
                }
                Section(header: Text("Size")) {
                    Picker("Size", selection: $size) {
                        ForEach(sizeOptions, id: \.self) { Text($0) }
                    }
                    .pickerStyle(.segmented)
                }
                Section(header: Text("Extras")) {
                    TextField("e.g. double-double", text: $extras)
                }
            }
            .navigationTitle("New Order")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let order = Order(name: name, drink: drink, size: size, extras: extras)
                        viewModel.addOrder(order)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
