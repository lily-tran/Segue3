//
//  Trip.swift
//  Segue3
//
//  Created by Lily Tran on 8/13/22.
//

import Foundation

struct Trip: Codable, Identifiable {
    let id: UUID
    let place: String
    let businesses: [Business]

}
