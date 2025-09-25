import SwiftUI

struct AddOrderView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: OrderViewModel

    @State private var name = ""
    @State private var item = ""
    @State private var size = ""
    @State private var extras = ""

    var onOrderPlaced: (() -> Void)? = nil

    let itemOptions = ["Coffee", "Latte", "Iced Capp", "Donut", "Bagel"]
    let sizeOptions = ["Small", "Medium", "Large"]

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Name")) {
                    TextField("Enter name", text: $name)
                }

                Section(header: Text("Item")) {
                    Picker("Item", selection: $item) {
                        ForEach(itemOptions, id: \.self) { Text($0) }
                    }
                }

                Section(header: Text("Size")) {
                    Picker("Size", selection: $size) {
                        ForEach(sizeOptions, id: \.self) { Text($0) }
                    }
                    .pickerStyle(.segmented)
                }

                Section(header: Text("Extras")) {
                    TextField("Enter extras", text: $extras)
                }
            }
            .navigationTitle("New Order")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Place Order") {
                        let order = Order(
                            name: name,
                            item: item,
                            size: size,
                            
                        )
                        viewModel.addOrder(order)
                        onOrderPlaced?()
                        dismiss()
                    }
                    .disabled(!isFormValid()) // ✅ Disable if form not fully filled
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func isFormValid() -> Bool {
        // All fields must be non-empty
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        !item.trimmingCharacters(in: .whitespaces).isEmpty &&
        !size.trimmingCharacters(in: .whitespaces).isEmpty &&
        !extras.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
