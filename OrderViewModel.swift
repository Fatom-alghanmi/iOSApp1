//
//  OrderViewModel.swift
//  TimHortonsRun
//
//  Created by Fatom on 2025-09-17.
//

import Foundation

class OrderViewModel: ObservableObject {
    @Published var orders: [Order] = [] {
        didSet { saveOrders() }
    }
    
    private let saveKey = "SavedOrders"
    
    init() {
        loadOrders()
    }
    
    func addOrder(_ order: Order) {
        orders.append(order)
    }
    
    private func saveOrders() {
        if let encoded = try? JSONEncoder().encode(orders) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    private func loadOrders() {
        if let savedData = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([Order].self, from: savedData) {
            orders = decoded
        }
    }
}
