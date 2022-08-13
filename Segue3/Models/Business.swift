//
//  Business.swift
//  Segue3
//
//  Created by Lily Tran on 8/12/22.
//

import Foundation

struct Businesses: Codable {
    let businesses: [Business]
}

struct Business: Identifiable, Codable {
    // let coordinates: Coordinates
    let id: String
    let image_url: URL
    // let location: Location
    let name: String
    let price: String?
    let rating: Float?
    let review_count: Int
    let url: String
    let categories: [String: String]
}

//struct ThisCategory: Identifiable, Codable {
//    var id: ObjectIdentifier
//
//    let alias: String
//    let title: String
//}

//struct Coordinates: Codable {
//    let latitude: Float
//    let longitude: Float
//}
//
//struct Location: Codable {
//    let address1: String
//    let address2: String?
//    let address3: String?
//    let city: String
//    let zip_code: String
//    let state: String
//}
