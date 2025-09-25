import SwiftUI

struct OrderListView: View {
    @ObservedObject var viewModel: OrderViewModel
    var goHome: (() -> Void)?
    var goBack: (() -> Void)?
    var onOrderPlaced: (() -> Void)? // callback
    
    @State private var showingAddOrder = false
    
    var body: some View {
        List {
            Section(header: Text("Orders")) {
                if viewModel.todayOrders.isEmpty {
                    Text("No orders found for today")
                        .foregroundColor(.gray)
                        .italic()
                } else {
                    ForEach(viewModel.todayOrders) { order in
                        NavigationLink(destination: OrderDetailView(order: order)) {
                            orderRow(order: order)
                        }
                    }
                    .onDelete { indexSet in
                        let ordersToDelete = indexSet.map { viewModel.todayOrders[$0] }
                        viewModel.orders.removeAll { order in
                            ordersToDelete.contains(where: { $0.id == order.id }) && Calendar.current.isDateInToday(order.date)
                        }
                    }
                    
                }
            }
        }
        
        .listStyle(.insetGrouped)
        .navigationTitle("Orders")
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
    
    private func orderRow(order: Order) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(order.name).font(.headline)
                Text("\(order.size) \(order.item)").font(.subheadline)
            }
            Spacer()
            if let notes = order.notes, !notes.isEmpty {
                Image(systemName: "note.text")
            }
        }
    }
}
