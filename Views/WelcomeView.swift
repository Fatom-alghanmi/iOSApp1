import SwiftUI

struct WelcomeView: View {
    @State private var currentPage = 1
    private let totalPages = 5
    @StateObject private var viewModel = OrderViewModel()
    @State private var showingAddOrder = false
    
    var body: some View {
        VStack(spacing: 30) {
            HeaderView(title: "Welcome to Tim Hortons Run",
                       totalPages: totalPages,
                       currentPage: $currentPage)  // <-- pass binding

            Spacer()
            // Page content
            switch currentPage {
            case 1:
                VStack(spacing: 20) {
                    Text("Fresh Coffee. Friendly Smiles. Always Tim Hortons.")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Image("timsLogo") // <-- if you have an asset, use it instead of SF Symbol
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)
                    
                    Text("Start your coffee run and keep track of your favorite orders!")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                }
            case 2:
                VStack(spacing: 20) {
                    Text("Add your favorite drinks and snacks here.")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Button(action: { showingAddOrder = true }) {
                        Text("Add a Sample Order")
                            .padding()
                            .background(Color.brown)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }

            case 3:
                VStack(spacing: 20) {
                    Text("Track your orders easily and quickly.")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Button(action: { currentPage = 5 }) { // jump to Orders list
                        Text("Go to Orders")
                            .padding()
                            .background(Color.brown)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }

            case 4:
                // RunTimerView page
                RunTimerView()

            case 5:
                // Orders page
                OrderListView(viewModel: viewModel)

            default:
                EmptyView()
            }

            
            Spacer()
            
            // Navigation buttons
            HStack {
                if currentPage > 1 && currentPage < 5 { // hide Previous on Orders page
                    Button("Previous") {
                        withAnimation { currentPage -= 1 }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                }
                
                Spacer()
                
                if currentPage < 4 { // hide Next on last intro page
                    Button("Next") {
                        withAnimation { currentPage += 1 }
                    }
                    .padding()
                    .background(Color.brown)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding(.horizontal)
        }
        .padding()
        .sheet(isPresented: $showingAddOrder) {
            AddOrderView(viewModel: viewModel)
        }
    }
}

#Preview {
    WelcomeView()
}
