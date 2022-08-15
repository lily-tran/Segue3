//
//  ActivityView.swift
//  Segue3
//
//  Created by Lily Tran on 8/15/22.
//

import SwiftUI

struct ActivityView: View {
    var trip: Trip
    var body: some View {
        VStack {
//            NavigationLink("Just on place name", destination: TinderAddBusinessView(trip: trip))
            Text("im dying")
            
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(trip: Trip(place: "San Diego, CA", businesses: []))
    }
}
