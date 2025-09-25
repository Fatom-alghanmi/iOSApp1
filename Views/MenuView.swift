//
//  MenuView.swift
//  TimHortonsRun
//
//  Created by Fatom on 2025-09-24.
//


import SwiftUI

struct MenuView: View {
    var goHome: (() -> Void)?
    var goBack: (() -> Void)?

    let menuItems = ["Coffee", "Latte", "Iced Capp", "Donut", "Bagel"]

    var body: some View {
        List(menuItems, id: \.self) { item in
            if let detail = menuDetails.first(where: { $0.name == item }) {
                NavigationLink(destination: MenuItemDetailView(menuItem: detail)) {
                    HStack {
                        Text(item)
                        Spacer()
                        Text(detail.price)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .navigationTitle("Menu")
        .toolbar {
            if let goBack = goBack {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: goBack) {
                        Label("Back", systemImage: "arrow.left")
                    }
                }
            }
            if let goHome = goHome {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: goHome) {
                        Label("Home", systemImage: "house.fill")
                    }
                }
            }
        }
    }
}
