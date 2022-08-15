//
//  PersistenceController.swift
//  Segue3
//
//  Created by Lily Tran on 8/12/22.
//

import Foundation
// MARK: - Persistence
// create a place to store our data, save data, load data
class TripController: ObservableObject {
    
    @Published var trips: [Trip] = []
    
    init() {
        loadFromPersistenceStore()
    }
    func createTrip(name: String) {
        let newTrip = Trip(place: name, businesses: [])
        trips.append(newTrip)
        saveToPersistenceStore()
        // loadFromPersistenceStore()
    }
    
    func deleteTrip(offsets: IndexSet) {
        trips.remove(atOffsets: offsets)
        saveToPersistenceStore()
        // loadFromPersistenceStore()
        
    }
    
    func findTrip(trip: Trip) -> Int {
        guard let index = trips.firstIndex(of: trip) else {
            return -10
        }
        return index
    }
    
    func addBusiness(trip: Trip, business: Business) {
        let index = findTrip(trip: trip)
        if index == -10 {
            return
        }
        trips[index].businesses.append(business)
        print(business.name)
        print("number of businesses: \(trips[index].businesses.count) in trip \(trips[index].place)")
        saveToPersistenceStore()
        // loadFromPersistenceStore()
    }
    
    func deleteBusiness(trip: Trip, offsets: IndexSet) {
        let index = findTrip(trip: trip)
        if index == -10 {
            return
        }
        trips[index].businesses.remove(atOffsets: offsets)
        saveToPersistenceStore()
        // loadFromPersistenceStore()
        
    }
    
    
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Segue3.json")
        // stored on the user's device
        return fileURL
    }
    
    func saveToPersistenceStore() {
        do {
            // so go make the Song class "Codable"
            // object array encoding to JSON data
            let data = try JSONEncoder().encode(trips)
            
            try data.write(to: createPersistenceStore())
        } catch {
            print("Error in \(#function): \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            // .self: HEY . look into this class
            //                              decode as , decode from
            trips = try JSONDecoder().decode([Trip].self, from: data)
        } catch {
            print("Error in \(#function): \(error.localizedDescription) \n---\n \(error)")
        }
    }
}
