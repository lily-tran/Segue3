//
//  BusinessListView.swift
//  Segue3
//
//  Created by Lily Tran on 8/14/22.
//

import SwiftUI

struct BusinessListView: View {
    //@State private var rootPresenting: Bool = false

    @ObservedObject var persist = TripController()
    @ObservedObject var trip: Trip
//
    var body: some View {
            VStack{ //(alignment: .center, spacing: 3)
                if !trip.businesses.isEmpty {
                    // If destinations to visit -------------------------------
                    List {
                        ForEach(trip.businesses) { business in
                            //NavigationLink(destination: <#T##Destination#>, label: <#T##() -> Label#>)
                            Text(business.name)
                        }
                        .onDelete { indexSet in
                            persist.deleteBusiness(trip: trip, offsets: indexSet)

                        }

                    }
                    .listStyle(.plain)
                    
                   
                } else {
                    // If no destinations to visit ----------------------------
                    Text("You should add some destinations to reach in \(trip.place)")
                    
                    //print("I want to do activities")
                    NavigationLink("To find my tinder places") {
                        TinderStackView(trip: trip, businesses: [])
                    }
                    
                
                    
                }
            }
            .onAppear{
                persist.loadFromPersistenceStore()
            }
            
            .navigationTitle("Things to Do")
            
//            .toolbar {
//                NavigationLink(destination: AddTripView(), isActive: $rootPresenting) {
//                    Label("Add", systemImage: "plus")
//                }
//            }

        //.environment(\.rootPresentation, $rootPresenting)
    }
}

struct BusinessListView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessListView(trip: Trip(place: "San Diego", businesses: []))
    }
}
