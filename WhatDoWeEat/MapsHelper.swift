//
//  MapsHelper.swift
//  WhatDoWeEat
//
//  Helper for opening Maps with search queries
//

import Foundation
import MapKit
import UIKit

struct MapsHelper {
    /// Opens Apple Maps with a search query
    static func openAppleMaps(with searchQuery: String) {
        let encodedQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? searchQuery

        // Use MKMapItem to search and open in Maps
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchQuery

        // Open Maps with the search query
        if let url = URL(string: "maps://?q=\(encodedQuery)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                // Fallback to web version if Maps app isn't available
                openAppleMapsWeb(with: searchQuery)
            }
        }
    }

    /// Opens Google Maps with a search query (requires Google Maps app installed)
    static func openGoogleMaps(with searchQuery: String) {
        let encodedQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? searchQuery

        if let url = URL(string: "comgooglemaps://?q=\(encodedQuery)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                // Fallback to web version if Google Maps app isn't installed
                openGoogleMapsWeb(with: searchQuery)
            }
        }
    }

    /// Opens Apple Maps in Safari as fallback
    private static func openAppleMapsWeb(with searchQuery: String) {
        let encodedQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? searchQuery
        if let url = URL(string: "https://maps.apple.com/?q=\(encodedQuery)") {
            UIApplication.shared.open(url)
        }
    }

    /// Opens Google Maps in Safari as fallback
    private static func openGoogleMapsWeb(with searchQuery: String) {
        let encodedQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? searchQuery
        if let url = URL(string: "https://www.google.com/maps/search/?api=1&query=\(encodedQuery)") {
            UIApplication.shared.open(url)
        }
    }
}
