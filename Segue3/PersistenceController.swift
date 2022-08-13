//
//  PersistenceController.swift
//  Segue3
//
//  Created by Lily Tran on 8/12/22.
//

import Foundation
// MARK: - Persistence
// create a place to store our data, save data, load data
class PersistenceController {
    
    static let shared = PersistenceController()
    var trips: [Trip] = []
    
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
            print("Error encoding our OBJECTS ARRAY")
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
            print("Error decoding out data into OBJECTS ARRAY.")
            print("Error in \(#function): \(error.localizedDescription) \n---\n \(error)")
        }
    }
}
