import SwiftUI

struct WelcomeView: View {
    @State private var currentPage = 1
    private let totalPages = 3
    @StateObject private var viewModel = OrderViewModel()
    @State private var showingAddOrder = false
    @State private var showSuccess = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {

                // MARK: — Fixed Welcome Header
                Text("Welcome to Tim Hortons Run")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 20)

                // MARK: — Page Selector Numbers
                HStack(spacing: 10) {
                    ForEach(1...totalPages, id: \.self) { page in
                        Button("\(page)") {
                            withAnimation { currentPage = page }
                        }
                        .padding(8)
                        .background(currentPage == page ? Color.brown : Color.gray.opacity(0.3))
                        .foregroundColor(.white)
                        .clipShape(Circle())
                    }
                }
                .padding(.bottom, 10)

                // MARK: — Points + Offer (only on first page)
                if currentPage == 1 {
                    VStack(spacing: 10) {
                        Text("Your Points: \(viewModel.points)")
                            .font(.title2)
                            .bold()

                        Text("Special Offer: Free Donut with any Large Coffee!")
                            .font(.subheadline)
                            .foregroundColor(.orange)

                        Image("coffeeDonut")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 250)
                            .padding(.bottom, 10)
                    }
                }

                Spacer()

                // MARK: — Pages
                switch currentPage {
                case 1:
                    introPage
                case 2:
                    addOrderPage
                case 3:
                    mainMenuPage
                default:
                    EmptyView()
                }

                Spacer()

                navigationButtons
                    .padding(.bottom, 20)
            }
            .padding(20)
            .sheet(isPresented: $showingAddOrder) {
                AddOrderView(viewModel: viewModel) {
                    showingAddOrder = false
                    showSuccess = true
                }
            }
            .overlay {
                if showSuccess {
                    SuccessView(message: "Order placed successfully!")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.4))
                        .transition(.opacity)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation { showSuccess = false }
                            }
                        }
                }
            }
        }
    }

    // MARK: - Pages

    var introPage: some View {
        VStack(spacing: 20) {
            Text("Fresh Coffee. Friendly Smiles. Always Tim Hortons.")
                .font(.title2)
                .multilineTextAlignment(.center)

            Image("timsLogo")
                .resizable()
                .scaledToFit()
                .frame(height: 180)

            Text("Start your coffee run and keep track of your favorite orders!")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.horizontal)
        }
    }

    var addOrderPage: some View {
        VStack(spacing: 20) {
            Text("Add your favorite drinks and snacks here.")
                .font(.title2)
                .multilineTextAlignment(.center)

            Image("pizza")
                .resizable()
                .scaledToFit()
                .frame(height: 250)

            Button(action: { showingAddOrder = true }) {
                Text("Add Order")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.brown)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
        }
    }

    var mainMenuPage: some View {
        VStack(spacing: 20) {
            NavigationLink(destination: OrderListView(
                viewModel: viewModel,
                goBack: { currentPage = 3 },
                onOrderPlaced: { showSuccess = true }
            )) {
                menuButton(title: "View Orders", color: .brown)
            }

            NavigationLink(destination: HistoryView(
                viewModel: viewModel,
                goBack: { currentPage = 3 }
            )) {
                menuButton(title: "View History", color: .gray)
            }

            NavigationLink(destination: RewardView(
                viewModel: viewModel,
                goBack: { currentPage = 3 }
            )) {
                menuButton(title: "Rewards", color: .orange)
            }

            NavigationLink(destination: AboutView(
                goBack: { currentPage = 3 }
            )) {
                menuButton(title: "About", color: .blue)
            }

            NavigationLink(destination: MenuView(
                goBack: { currentPage = 3 }
            )) {
                menuButton(title: "Menu", color: .green)
            }

            NavigationLink(destination: FavoritesView(
                viewModel: viewModel,
                goBack: { currentPage = 3 }
            )) {
                menuButton(title: "Favorites", color: .pink)
            }
        }
        .padding(.horizontal)
    }

    // MARK: - Navigation Buttons

    var navigationButtons: some View {
        HStack {
            if currentPage > 1 {
                Button("Previous") {
                    withAnimation { currentPage -= 1 }
                }
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
            }

            Spacer()

            if currentPage < totalPages {
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

    // MARK: - Button Helper

    func menuButton(title: String, color: Color) -> some View {
        Text(title)
            .padding()
            .frame(maxWidth: .infinity)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(12)
    }
}

#Preview {
    WelcomeView()
}
