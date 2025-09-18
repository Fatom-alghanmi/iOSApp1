//
//  ContentView.swift
//  TimHortonsRun
//
//  Created by Fatom on 2025-09-17.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = OrderViewModel()  // shared instance

    var body: some View {
        TabView {
            OrderListView(viewModel: viewModel)  // pass viewModel
                .tabItem {
                    Label("Orders", systemImage: "cup.and.saucer.fill")
                }

            RunTimerView()
                .tabItem {
                    Label("Timer", systemImage: "timer")
                }
        }
    }
}
#Preview {
    ContentView()
}


