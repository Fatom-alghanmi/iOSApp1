import Foundation

class OrderViewModel: ObservableObject {
    @Published var orders: [Order] = [] {
        didSet { saveOrders() }
    }

    @Published var favorites: [Order] = [] {
        didSet { saveFavorites() }
    }

    @Published var points: Int = 120 { // Add points for RewardView
        didSet { savePoints() }
    }

    /// Returns only orders placed today
    var todayOrders: [Order] {
        orders.filter { Calendar.current.isDateInToday($0.date) }
    }

    private let ordersKey = "SavedOrders"
    private let favoritesKey = "SavedFavorites"
    private let pointsKey = "UserPoints"

    init() {
        loadOrders()
        loadFavorites()
        loadPoints()
    }

    func addOrder(_ order: Order) {
        orders.append(order)
        points += 10 // Example: add points per order
    }

    func addFavorite(_ order: Order) {
        if favorites.contains(where: { $0.id == order.id }) {
            favorites.removeAll { $0.id == order.id }
        } else {
            favorites.append(order)
        }
    }

    func removeFavorite(_ order: Order) {
        favorites.removeAll { $0.id == order.id }
        saveFavorites()
    }

    func deleteOrder(atOffsets offsets: IndexSet) {
        orders.remove(atOffsets: offsets)
    }

    private func saveOrders() {
        if let encoded = try? JSONEncoder().encode(orders) {
            UserDefaults.standard.set(encoded, forKey: ordersKey)
        }
    }

    private func loadOrders() {
        if let savedData = UserDefaults.standard.data(forKey: ordersKey),
           let decoded = try? JSONDecoder().decode([Order].self, from: savedData) {
            orders = decoded
        }
    }

    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }

    private func loadFavorites() {
        if let savedData = UserDefaults.standard.data(forKey: favoritesKey),
           let decoded = try? JSONDecoder().decode([Order].self, from: savedData) {
            favorites = decoded
        }
    }

    private func savePoints() {
        UserDefaults.standard.set(points, forKey: pointsKey)
    }

    private func loadPoints() {
        points = UserDefaults.standard.integer(forKey: pointsKey)
    }
}
