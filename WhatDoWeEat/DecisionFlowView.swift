//
//  DecisionFlowView.swift
//  WhatDoWeEat
//
//  Main decision flow interface with all steps
//

import SwiftUI

struct DecisionFlowView: View {
    @State private var viewModel = DecisionViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: backgroundColors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack {
                // Header with back button
                HStack {
                    if viewModel.currentStep != .cuisine {
                        Button {
                            viewModel.goBack()
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: "chevron.left")
                                Text("Back")
                            }
                            .font(.system(size: 17, weight: .medium))
                            .foregroundStyle(.white)
                        }
                    }

                    Spacer()

                    Button {
                        viewModel.reset()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 17, weight: .medium))
                            .foregroundStyle(.white)
                    }
                }
                .padding()

                // Main content
                switch viewModel.currentStep {
                case .cuisine:
                    CuisineSelectionView(viewModel: viewModel)
                case .serviceType:
                    ServiceTypeSelectionView(viewModel: viewModel)
                case .result:
                    ResultView(viewModel: viewModel)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    private var backgroundColors: [Color] {
        switch viewModel.currentStep {
        case .cuisine:
            return [
                Color(red: 1.0, green: 0.8, blue: 0.4),
                Color(red: 1.0, green: 0.6, blue: 0.3)
            ]
        case .serviceType:
            return [
                Color(red: 0.4, green: 0.8, blue: 1.0),
                Color(red: 0.3, green: 0.6, blue: 1.0)
            ]
        case .result:
            return [
                Color(red: 0.5, green: 0.9, blue: 0.5),
                Color(red: 0.3, green: 0.7, blue: 0.5)
            ]
        }
    }
}

// MARK: - Cuisine Selection View
struct CuisineSelectionView: View {
    let viewModel: DecisionViewModel

    var body: some View {
        VStack(spacing: 20) {
            // Question
            VStack(spacing: 8) {
                Text("What sounds good?")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)

                Text("Pick a cuisine type")
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .foregroundStyle(.white.opacity(0.9))
            }
            .padding(.top, 20)

            Spacer()

            // Cuisine options in a grid
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 16),
                GridItem(.flexible(), spacing: 16)
            ], spacing: 16) {
                ForEach(CuisineType.allCases) { cuisine in
                    CuisineOptionCard(cuisine: cuisine) {
                        viewModel.selectCuisine(cuisine)
                    }
                }
            }
            .padding(.horizontal, 20)

            Spacer()
        }
        .transition(.asymmetric(
            insertion: .move(edge: .trailing).combined(with: .opacity),
            removal: .move(edge: .leading).combined(with: .opacity)
        ))
    }
}

// MARK: - Service Type Selection View
struct ServiceTypeSelectionView: View {
    let viewModel: DecisionViewModel

    var body: some View {
        VStack(spacing: 20) {
            // Question
            VStack(spacing: 8) {
                if let cuisine = viewModel.selectedCuisine {
                    Text("\(cuisine.emoji) \(cuisine.rawValue)")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                }

                Text("How do you want it?")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)

                Text("Choose your dining style")
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .foregroundStyle(.white.opacity(0.9))
            }
            .padding(.top, 20)

            Spacer()

            // Service type options
            VStack(spacing: 16) {
                ForEach(ServiceType.allCases) { serviceType in
                    ServiceTypeOptionCard(serviceType: serviceType) {
                        viewModel.selectServiceType(serviceType)
                    }
                }
            }
            .padding(.horizontal, 30)

            Spacer()
        }
        .transition(.asymmetric(
            insertion: .move(edge: .trailing).combined(with: .opacity),
            removal: .move(edge: .leading).combined(with: .opacity)
        ))
    }
}

// MARK: - Result View
struct ResultView: View {
    let viewModel: DecisionViewModel

    var body: some View {
        VStack(spacing: 30) {
            Spacer()

            // Success icon
            ZStack {
                Circle()
                    .fill(.white)
                    .frame(width: 120, height: 120)
                    .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)

                Text("🎉")
                    .font(.system(size: 60))
            }

            // Result text
            VStack(spacing: 12) {
                Text("Perfect Choice!")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)

                if let decision = viewModel.finalDecision {
                    Text("\(decision.cuisine.emoji) \(decision.description)")
                        .font(.system(size: 24, weight: .semibold, design: .rounded))
                        .foregroundStyle(.white.opacity(0.95))
                        .multilineTextAlignment(.center)

                    Text(decision.suggestionText)
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundStyle(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .padding(.top, 8)
                }
            }

            Spacer()

            // Action buttons
            VStack(spacing: 16) {
                Button {
                    viewModel.reset()
                } label: {
                    HStack {
                        Image(systemName: "arrow.clockwise")
                        Text("Start Over")
                    }
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color(red: 0.3, green: 0.7, blue: 0.5))
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(.white)
                    .cornerRadius(18)
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                }
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
        }
        .transition(.asymmetric(
            insertion: .move(edge: .trailing).combined(with: .opacity),
            removal: .move(edge: .leading).combined(with: .opacity)
        ))
    }
}

// MARK: - Cuisine Option Card
struct CuisineOptionCard: View {
    let cuisine: CuisineType
    let action: () -> Void

    @State private var isPressed = false

    var body: some View {
        Button {
            action()
        } label: {
            VStack(spacing: 12) {
                Text(cuisine.emoji)
                    .font(.system(size: 50))

                Text(cuisine.rawValue)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundStyle(.primary)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 140)
            .background(.white)
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.15), radius: isPressed ? 5 : 10, x: 0, y: isPressed ? 2 : 5)
            .scaleEffect(isPressed ? 0.95 : 1.0)
        }
        .buttonStyle(.plain)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
    }
}

// MARK: - Service Type Option Card
struct ServiceTypeOptionCard: View {
    let serviceType: ServiceType
    let action: () -> Void

    @State private var isPressed = false

    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 16) {
                Text(serviceType.emoji)
                    .font(.system(size: 40))

                Text(serviceType.rawValue)
                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                    .foregroundStyle(.primary)

                Spacer()

                Image(systemName: "arrow.right.circle.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(Color(red: 0.3, green: 0.6, blue: 1.0))
            }
            .padding(.horizontal, 24)
            .frame(height: 80)
            .background(.white)
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.15), radius: isPressed ? 5 : 10, x: 0, y: isPressed ? 2 : 5)
            .scaleEffect(isPressed ? 0.98 : 1.0)
        }
        .buttonStyle(.plain)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
    }
}

#Preview {
    NavigationStack {
        DecisionFlowView()
    }
}
