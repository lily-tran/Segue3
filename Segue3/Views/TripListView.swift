//
//  TripListView.swift
//  Segue3
//
//  Created by Lily Tran on 8/13/22.
//

import SwiftUI

struct TripListView: View {
    // @ObservedObject private var bvm = BusinessViewModel()
    private var persist = TripController.shared
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 3){
                List {
                    ForEach(persist.trips) { trip in
                        //TinderCardView(business: business)
                        Text(trip.place)
                        
                    }
                    .onDelete(perform: deleteTrip(offsets:))
                }
                .listStyle(.plain)
            }
            .navigationTitle("Adventures Await")
            .toolbar {
                NavigationLink(destination: AddTripView()) {
                    Label("Add", systemImage: "plus")
                }
            }
        }
        .onAppear{
            persist.loadFromPersistenceStore()
        }
    }
    private func deleteTrip(offsets: IndexSet) {
        for offset in offsets {
            let trip = persist.trips[offset]
            persist.deleteTrip(trip: trip)
        }
    }


}

struct TripListView_Previews: PreviewProvider {
    static var previews: some View {
        TripListView()
    }
}
