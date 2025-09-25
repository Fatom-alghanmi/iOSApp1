import SwiftUI

struct HistoryView: View {
    @ObservedObject var viewModel: OrderViewModel
    @Environment(\.dismiss) var dismiss

    var goBack: (() -> Void)?
 

    var body: some View {
        List {
            Section(header: Text("Order History")) {
                if viewModel.orders.isEmpty {
                    Text("No history found")
                        .foregroundColor(.gray)
                        .italic()
                } else {
                    ForEach(viewModel.orders) { order in
                        NavigationLink(destination: OrderDetailView(order: order)) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(order.name).font(.headline)
                                    Text("\(order.size) \(order.item)")
                                        .font(.subheadline)
                                }
                                Spacer()
                                if let notes = order.notes, !notes.isEmpty {
                                    Image(systemName: "note.text")
                                }
                            }
                        }
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("History")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                if let goBack = goBack {
                    Button(action: goBack) {
                        Label("Back", systemImage: "arrow.left")
                    }
                }
            }
        }
    }
}
