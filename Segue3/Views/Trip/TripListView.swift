//
//  TripListView.swift
//  Segue3
//
//  Created by Lily Tran on 8/13/22.
//

import SwiftUI

struct TripListView: View {
    @State private var rootPresenting: Bool = false

    @ObservedObject var persist = TripController()
//
    var body: some View {
        NavigationView {
            VStack{ //(alignment: .center, spacing: 3)
                List {
                    ForEach(persist.trips) { trip in
                        NavigationLink(destination: BusinessListView(trip: trip)) {
                            Text(trip.place)
                        }
                    }
                    .onDelete(perform: persist.deleteTrip )
                }
                .listStyle(.plain)
            }
            .onAppear{
                persist.loadFromPersistenceStore()
            }
            
            .navigationTitle("Adventures Await")
            
            .toolbar {
                NavigationLink(destination: AddTripView(), isActive: $rootPresenting) {
                    Label("Add", systemImage: "plus")
                }
            }
        }
        .environment(\.rootPresentation, $rootPresenting)
    }



}

struct TripListView_Previews: PreviewProvider {
    static var previews: some View {
        TripListView()
    }
}
