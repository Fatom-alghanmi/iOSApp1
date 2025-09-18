//
//  HeaderView.swift
//  TimHortonsRun
//
//  Created by Fatom on 2025-09-17.
//
import SwiftUI

struct HeaderView: View {
    let title: String
    let totalPages: Int
    @Binding var currentPage: Int   // <-- must be @Binding
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.largeTitle)
                .bold()
            
            HStack(spacing: 15) {
                ForEach(1...totalPages, id: \.self) { num in
                    Button(action: {
                        currentPage = num   // click to jump
                    }) {
                        Image(systemName: "\(num).circle")
                            .font(.title2)
                            .foregroundColor(num == currentPage ? .brown : .gray)
                    }
                }
            }
        }
        .padding()
    }
}

