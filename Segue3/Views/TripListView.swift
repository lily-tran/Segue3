//
//  TripListView.swift
//  Segue3
//
//  Created by Lily Tran on 8/13/22.
//

import SwiftUI

struct TripListView: View {
    @ObservedObject private var bvm = BusinessViewModel()
    private var persist = PersistenceController.shared
    
    var body: some View {
        VStack(alignment: .center, spacing: 3){
            List {
                ForEach(persist.trips) { trip in
                //TinderCardView(business: business)
                    Text("you have reached the end!")
            }
            Text("you have reached the end!")
            }
        }
        //.navigationTitle("Events")
    }
}

struct TripListView_Previews: PreviewProvider {
    static var previews: some View {
        TripListView()
    }
}
