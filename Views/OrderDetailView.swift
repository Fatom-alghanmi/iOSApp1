//
//  OrderDetailView.swift
//  TimHortonsRun
//
//  Created by Fatom on 2025-09-17.
//

import SwiftUI

struct OrderDetailView: View {
    let order: Order

    var body: some View {
        VStack(spacing: 20) {
            Text(order.name)
                .font(.largeTitle)
            
            Text("\(order.size) \(order.item)")
                .font(.title2)
            
            if let notes = order.notes, !notes.isEmpty {
                Text("Notes: \(notes)")
                    .font(.body)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Order Detail")
    }
}
