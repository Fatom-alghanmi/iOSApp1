import SwiftUI

struct RewardView: View {
    @ObservedObject var viewModel: OrderViewModel
    @State private var showingAddOrder = false

    var goBack: (() -> Void)?
    var goToOrders: (() -> Void)?

    struct Reward: Identifiable {
        let id = UUID()
        let title: String
        let pointsRequired: Int
    }

    let rewards = [
        Reward(title: "Free Small Coffee", pointsRequired: 50),
        Reward(title: "Free Donut", pointsRequired: 100),
        Reward(title: "Free Large Coffee", pointsRequired: 200),
        Reward(title: "Free Breakfast Sandwich", pointsRequired: 300)
    ]

    var body: some View {
        VStack(spacing: 20) {
            Text("Tim Hortons Rewards")
                .font(.largeTitle)
                .bold()

            Text("Points: \(viewModel.points)")
                .font(.title2)
                .padding(.bottom, 20)

            List(rewards) { reward in
                HStack {
                    VStack(alignment: .leading) {
                        Text(reward.title)
                            .font(.headline)
                        Text("\(reward.pointsRequired) points")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    if viewModel.points >= reward.pointsRequired {
                        Button("Redeem") {
                            viewModel.points -= reward.pointsRequired
                        }
                        .padding(8)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    } else {
                        Button("Locked") {}
                            .disabled(true)
                            .padding(8)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding(.vertical, 5)
            }

            Spacer()

            Button("Earn More Points") {
                showingAddOrder = true
            }
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .sheet(isPresented: $showingAddOrder) {
            AddOrderView(viewModel: viewModel)
        }
        .padding()
        .navigationTitle("Rewards")
        .toolbar {
            if let goBack = goBack {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: goBack) {
                        Label("Back", systemImage: "arrow.left")
                    }
                }
            }
        }
    }
}
