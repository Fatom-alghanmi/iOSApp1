//
//  NavigationHeaderView.swift
//  TimHortonsRun
//
//  Created by Fatom on 2025-09-24.
//

import SwiftUI

struct NavigationHeaderView: View {
    var title: String
    var goBack: (() -> Void)? = nil
    var goHome: (() -> Void)? = nil

    var body: some View {
        HStack {
            if let goBack = goBack {
                Button(action: goBack) {
                    Label("Back", systemImage: "arrow.left")
                }
            }

            Spacer()
            
            Text(title)
                .font(.headline)
                .bold()

            Spacer()

            if let goHome = goHome {
                Button(action: goHome) {
                    Label("Home", systemImage: "house.fill")
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemGroupedBackground))
    }
}
