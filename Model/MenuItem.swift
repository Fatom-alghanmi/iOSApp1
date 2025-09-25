//
//  MenuItem.swift
//  TimHortonsRun
//
//  Created by Fatom on 2025-09-25.
//

import Foundation

struct MenuItem: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let options: [String]
    let price: String
}

let menuDetails: [MenuItem] = [
    MenuItem(name: "Coffee", description: "Freshly brewed coffee.", options: ["Small", "Medium", "Large"], price: "$2.00"),
    MenuItem(name: "Latte", description: "Smooth espresso with steamed milk.", options: ["Small", "Medium", "Large"], price: "$3.50"),
    MenuItem(name: "Iced Capp", description: "Chilled cappuccino with ice.", options: ["Small", "Medium", "Large"], price: "$4.00"),
    MenuItem(name: "Donut", description: "Sweet, fluffy donuts in many flavors.", options: ["Glazed", "Chocolate", "Sprinkles", "Maple"], price: "$1.50"),
    MenuItem(name: "Bagel", description: "Freshly baked bagels with a variety of toppings.", options: ["Plain", "Sesame", "Everything", "Cinnamon Raisin"], price: "$2.50")
]
