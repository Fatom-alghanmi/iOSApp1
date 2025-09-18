import SwiftUI

struct OrderListView: View {
    @ObservedObject var viewModel: OrderViewModel         // Injected from WelcomeView
    var goHome: (() -> Void)? = nil                        // Optional closure to return to Welcome

    @State private var showingAddOrder = false

    // MARK: - Computed properties
    private var recentOrders: [Order] {
        viewModel.orders.filter { Calendar.current.isDateInToday($0.date) }
    }

    private var historyOrders: [Order] {
        viewModel.orders.filter { !Calendar.current.isDateInToday($0.date) }
    }

    var body: some View {
        NavigationStack {
            List {
                // MARK: Recent Orders Section
                Section(header: Text("Recent Orders")) {
                    if recentOrders.isEmpty {
                        Text("No recent orders")
                            .foregroundColor(.gray)
                            .italic()
                    } else {
                        ForEach(recentOrders) { order in
                            NavigationLink(destination: OrderDetailView(order: order)) {
                                orderRow(order: order)
                            }
                        }
                        .onDelete { indexSet in
                            deleteOrders(at: indexSet, from: recentOrders)
                        }
                    }
                }

                // MARK: History Section
                Section(header: Text("History")) {
                    if historyOrders.isEmpty {
                        Text("No past orders")
                            .foregroundColor(.gray)
                            .italic()
                    } else {
                        ForEach(historyOrders) { order in
                            NavigationLink(destination: OrderDetailView(order: order)) {
                                orderRow(order: order)
                            }
                        }
                        .onDelete { indexSet in
                            deleteOrders(at: indexSet, from: historyOrders)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Orders")
            .toolbar {
                // Add Order Button
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { showingAddOrder = true }) {
                        Label("Add Order", systemImage: "plus")
                    }
                }
                
                // Optional Home Button
                if let goHome = goHome {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: goHome) {
                            Label("Home", systemImage: "house.fill")
                        }
                    }
                }
            }
            .sheet(isPresented: $showingAddOrder) {
                AddOrderView(viewModel: viewModel)
            }
        }
    }

    // MARK: - Helper functions
    private func orderRow(order: Order) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(order.name).font(.headline)
                Text("\(order.size) \(order.drink)").font(.subheadline)
            }
            Spacer()
            if let notes = order.notes, !notes.isEmpty {
                Image(systemName: "note.text")
            }
        }
    }

    private func deleteOrders(at offsets: IndexSet, from ordersArray: [Order]) {
        for index in offsets {
            if let originalIndex = viewModel.orders.firstIndex(of: ordersArray[index]) {
                viewModel.orders.remove(at: originalIndex)
            }
        }
    }
}

#Preview {
    // Sample preview with a shared view model
    let vm = OrderViewModel()
    vm.orders = [
        Order(name: "Fatom", drink: "Iced Capp", size: "Large", notes: "Extra sugar"),
        Order(name: "Ali", drink: "Double Double", size: "Medium")
    ]
    return OrderListView(viewModel: vm)
}
