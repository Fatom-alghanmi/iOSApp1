import SwiftUI

struct AboutView: View {
    var goBack: (() -> Void)?

    var body: some View {
        VStack(spacing: 20) {
            Text("About Tim Hortons Run")
                .font(.largeTitle)
                .bold()

            Text("This app helps you track your Tim Hortons coffee runs, manage favorite orders, and earn rewards!")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
        }
        .navigationTitle("About")
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
