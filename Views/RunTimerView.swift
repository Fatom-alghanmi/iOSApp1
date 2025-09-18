//
//  RunTimerView.swift
//  TimHortonsRun
//
//  Created by Fatom on 2025-09-17.
//

import SwiftUI

struct RunTimerView: View {
    @State private var timeRemaining = 300 // 5 minutes for coffee run
    @State private var timerActive = false
    @State private var timer: Timer? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Coffee Run Timer")
                .font(.largeTitle)
                .bold()
            
            Text("\(timeRemaining / 60):\(String(format: "%02d", timeRemaining % 60))")
                .font(.system(size: 48, weight: .bold, design: .monospaced))
            
            HStack {
                Button(timerActive ? "Pause" : "Start") {
                    if timerActive {
                        timer?.invalidate()
                    } else {
                        startTimer()
                    }
                    timerActive.toggle()
                }
                .buttonStyle(.borderedProminent)
                
                Button("Reset") {
                    resetTimer()
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
                timerActive = false
            }
        }
    }
    
    func resetTimer() {
        timer?.invalidate()
        timeRemaining = 300
        timerActive = false
    }
}
