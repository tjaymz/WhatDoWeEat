//
//  Models.swift
//  WhatDoWeEat
//
//  Data models for the food decision app
//

import Foundation

// MARK: - Decision Step Types
enum DecisionStep {
    case cuisine
    case serviceType
    case result
}

// MARK: - Cuisine Types
enum CuisineType: String, CaseIterable, Identifiable {
    case american = "American"
    case chinese = "Chinese"
    case mexican = "Mexican"
    case italian = "Italian"
    case japanese = "Japanese"
    case thai = "Thai"
    case indian = "Indian"
    case mediterranean = "Mediterranean"

    var id: String { rawValue }

    var emoji: String {
        switch self {
        case .american: return "🍔"
        case .chinese: return "🥡"
        case .mexican: return "🌮"
        case .italian: return "🍝"
        case .japanese: return "🍱"
        case .thai: return "🍜"
        case .indian: return "🍛"
        case .mediterranean: return "🥙"
        }
    }
}

// MARK: - Service Types
enum ServiceType: String, CaseIterable, Identifiable {
    case fastFood = "Fast Food"
    case dineIn = "Dine-In"
    case takeOut = "Take Out"
    case delivery = "Delivery"

    var id: String { rawValue }

    var emoji: String {
        switch self {
        case .fastFood: return "⚡"
        case .dineIn: return "🪑"
        case .takeOut: return "🥡"
        case .delivery: return "🚗"
        }
    }
}

// MARK: - Decision Result
struct FoodDecision: Identifiable {
    let id = UUID()
    let cuisine: CuisineType
    let serviceType: ServiceType

    var description: String {
        "\(cuisine.rawValue) - \(serviceType.rawValue)"
    }

    var suggestionText: String {
        switch (cuisine, serviceType) {
        case (.american, .fastFood):
            return "How about a burger from Five Guys or Shake Shack?"
        case (.american, .dineIn):
            return "Try a local American grill or steakhouse!"
        case (.chinese, .fastFood):
            return "Panda Express or a local Chinese takeout spot?"
        case (.chinese, .dineIn):
            return "Find a nice Chinese restaurant for sit-down dining!"
        case (.mexican, .fastFood):
            return "Chipotle or Taco Bell could hit the spot!"
        case (.mexican, .dineIn):
            return "Look for an authentic Mexican restaurant nearby!"
        case (.italian, .fastFood):
            return "How about a quick pasta from a local Italian spot?"
        case (.italian, .dineIn):
            return "Find a cozy Italian restaurant with ambiance!"
        case (.japanese, .takeOut):
            return "Order some fresh sushi or ramen to go!"
        case (.japanese, .dineIn):
            return "Visit a Japanese restaurant for the full experience!"
        case (.thai, .takeOut), (.thai, .delivery):
            return "Thai food travels well - pad thai or curry?"
        case (.indian, .takeOut), (.indian, .delivery):
            return "Order some delicious curry and naan!"
        default:
            return "Great choice! Look for \(cuisine.rawValue) places that offer \(serviceType.rawValue.lowercased())."
        }
    }

    var mapsSearchQuery: String {
        // Generate optimized search query for Maps
        let serviceModifier: String
        switch serviceType {
        case .fastFood:
            serviceModifier = "fast food"
        case .dineIn:
            serviceModifier = "restaurants"
        case .takeOut:
            serviceModifier = "takeout"
        case .delivery:
            serviceModifier = "delivery"
        }
        return "\(cuisine.rawValue) \(serviceModifier) near me"
    }
}
