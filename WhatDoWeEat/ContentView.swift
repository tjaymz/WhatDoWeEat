//
//  ContentView.swift
//  WhatDoWeEat
//
//  Main landing screen
//

import SwiftUI

struct ContentView: View {
    @State private var showDecisionFlow = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Gradient background
                LinearGradient(
                    colors: [
                        Color(red: 0.95, green: 0.5, blue: 0.2),
                        Color(red: 0.9, green: 0.3, blue: 0.15)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 30) {
                    Spacer()

                    // App icon
                    ZStack {
                        Circle()
                            .fill(.white)
                            .frame(width: 140, height: 140)
                            .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)

                        Text("🍽️")
                            .font(.system(size: 70))
                    }

                    // Title
                    VStack(spacing: 10) {
                        Text("What Do We Eat?")
                            .font(.system(size: 42, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                            .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                            .multilineTextAlignment(.center)

                        Text("Let's help you decide!")
                            .font(.system(size: 20, weight: .medium, design: .rounded))
                            .foregroundStyle(.white)
                            .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                    }

                    Spacer()

                    // Start button
                    Button {
                        showDecisionFlow = true
                    } label: {
                        HStack {
                            Text("Start Deciding")
                                .font(.system(size: 22, weight: .semibold, design: .rounded))
                            Image(systemName: "arrow.right.circle.fill")
                                .font(.system(size: 22))
                        }
                        .foregroundStyle(Color(red: 0.9, green: 0.3, blue: 0.15))
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(.white)
                        .cornerRadius(20)
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 60)
                }
            }
            .navigationDestination(isPresented: $showDecisionFlow) {
                DecisionFlowView()
            }
        }
    }
}

#Preview {
    ContentView()
}
