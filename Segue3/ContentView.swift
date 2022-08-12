//
//  ContentView.swift
//  Segue3
//
//  Created by Lily Tran on 8/12/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var bvm = BusinessViewModel()
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class BusinessViewModel: ObservableObject {
    @Published var businesses: [Business] = []
    func getEvents(location: String) {
        YelpFusionController.fetchYelpRequsts(location: location) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let events):
                    self.businesses = events
                case .failure(let error):
                    print("There was an error with call to fetchEvents(): \(error.localizedDescription) -> \(error)")
                                    }
            }
        }
        
    }
}
