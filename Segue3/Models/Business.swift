//
//  Business.swift
//  Segue3
//
//  Created by Lily Tran on 8/12/22.
//

import Foundation

struct Businesses: Decodable, Identifiable {
    let businesses: [Business]
}

struct Business: Decodable {
    let coordinates: Coordinates
    let id: String
    let image_url: String
    let location: Location
    let name: String
    let price: String?
    let rating: Float?
    let review_count: Int
    let url: String
    let categories: [Category]
}

struct Category: Decodable {
    let alias: String
    let title: String
}

struct Coordinates: Decodable {
    let latitude: Float
    let longitude: Float
}

struct Location: Decodable {
    let address1: String
    let address2: String?
    let address3: String?
    let city: String
    let zip_code: String
    let state: String
}
