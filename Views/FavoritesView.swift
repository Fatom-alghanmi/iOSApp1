import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: OrderViewModel
    
    var goBack: (() -> Void)?
    var goHome: (() -> Void)?

    var body: some View {
        List {
            if viewModel.favorites.isEmpty {
                Text("No favorites yet.")
                    .foregroundColor(.gray)
                    .italic()
            } else {
                ForEach(viewModel.favorites) { order in
                    HStack {
                        NavigationLink(destination: OrderDetailView(order: order)) {
                            VStack(alignment: .leading) {
                                Text(order.name).font(.headline)
                                Text("\(order.size) \(order.item)").font(.subheadline)
                            }
                        }
                        
                        Spacer()
                        
                        if let notes = order.notes, !notes.isEmpty {
                            Image(systemName: "note.text")
                        }
                        
                        Button(action: {
                            viewModel.removeFavorite(order)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                        .buttonStyle(.plain) // avoid NavigationLink tap
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Favorites")
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

