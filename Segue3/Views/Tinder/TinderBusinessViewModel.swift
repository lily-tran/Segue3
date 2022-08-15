//
//  TinderBusinessViewModel.swift
//  Segue3
//
//  Created by Lily Tran on 8/15/22.
////
//
//import SwiftUI
//
//class TinderBusinessViewModel: ObservableObject {
//    private var trip: Trip
//    @Published var businesses: [Business] = []
//    @Published var businessImage: UIImage = ((UIImage(systemName: "circle") ?? UIImage(systemName: "square"))!)
//    
//    init(trip: Trip) {
//        self.trip = trip
//        DispatchQueue.main.async {
//            self.getEvents(location: self.trip.place)
//        }
//    }
//
//
//}
