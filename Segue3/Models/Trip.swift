//
//  Trip.swift
//  Segue3
//
//  Created by Lily Tran on 8/13/22.
//

import Foundation

class Trip: Codable, Identifiable {
    let id: UUID
    let place: String
    var businesses: [Business]
    
    init(id: UUID = UUID(), place: String, businesses: [Business]) {
        self.id = id
        self.place = place
        self.businesses = businesses
    }

}

extension Trip: Equatable {
    static func == (rhs: Trip, lhs: Trip) -> Bool {
        return rhs.id == lhs.id
    }
    
}
