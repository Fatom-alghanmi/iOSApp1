//
//  ContentView.swift
//  TimHortonsRun
//
//  Created by Fatom on 2025-09-17.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = OrderViewModel()
    @State private var showingAddOrder = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.orders) { order in
                    VStack(alignment: .leading) {
                        Text(order.name).font(.headline)
                        Text("\(order.size) \(order.drink) - \(order.extras)")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Tim Hortons Run")
            .toolbar {
                Button(action: { showingAddOrder = true }) {
                    Label("Add Order", systemImage: "plus")
                }
            }
            .sheet(isPresented: $showingAddOrder) {
                AddOrderView(viewModel: viewModel)
            }
        }
    }
}

