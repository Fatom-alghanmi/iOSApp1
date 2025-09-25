import SwiftUI

struct SuccessView: View {
    var message: String = "Order placed successfully!"

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.green)

            Text(message)
                .font(.title2)
                .bold()

            Text("Thank you for ordering with Tim Hortons!")
                .font(.body)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 10)
    }
}
