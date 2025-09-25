//
//  MenuItemDetailView.swift
//  TimHortonsRun
//
//  Created by Fatom on 2025-09-25.
//


import SwiftUI

struct MenuItemDetailView: View {
    let menuItem: MenuItem

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(menuItem.name)
                .font(.largeTitle)
                .bold()

            Text(menuItem.description)
                .font(.body)

            Divider()

            Text("Options:")
                .font(.headline)

            ForEach(menuItem.options, id: \.self) { option in
                Text("• \(option)")
            }

            Divider()

            Text("Price: \(menuItem.price)")
                .font(.headline)

            Spacer()
        }
        .padding()
        .navigationTitle(menuItem.name)
    }
}
