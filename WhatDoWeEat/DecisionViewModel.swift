//
//  DecisionViewModel.swift
//  WhatDoWeEat
//
//  View model to manage the decision flow state
//

import SwiftUI

@Observable
class DecisionViewModel {
    var currentStep: DecisionStep = .cuisine
    var selectedCuisine: CuisineType?
    var selectedServiceType: ServiceType?
    var finalDecision: FoodDecision?

    func selectCuisine(_ cuisine: CuisineType) {
        selectedCuisine = cuisine
        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
            currentStep = .serviceType
        }
    }

    func selectServiceType(_ serviceType: ServiceType) {
        selectedServiceType = serviceType
        if let cuisine = selectedCuisine {
            finalDecision = FoodDecision(cuisine: cuisine, serviceType: serviceType)
            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                currentStep = .result
            }
        }
    }

    func reset() {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
            currentStep = .cuisine
            selectedCuisine = nil
            selectedServiceType = nil
            finalDecision = nil
        }
    }

    func goBack() {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
            switch currentStep {
            case .cuisine:
                break
            case .serviceType:
                currentStep = .cuisine
                selectedCuisine = nil
            case .result:
                currentStep = .serviceType
                selectedServiceType = nil
                finalDecision = nil
            }
        }
    }
}
