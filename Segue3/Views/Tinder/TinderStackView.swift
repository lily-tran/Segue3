//
//  TinderStackView.swift
//  Segue3
//
//  Created by Lily Tran on 8/15/22.
//

import SwiftUI

struct TinderStackView: View {
    @ObservedObject var trip: Trip
    @State var businesses: [Business] // businesses to swipe through
    
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
    
    /// Return the CardViews width for the given offset in the array
    /// - Parameters:
    ///   - geometry: The geometry proxy of the parent
    ///   - id: The ID of the current user
    private func getCardWidth(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        let offset: CGFloat = CGFloat(businesses.count - 1 - id) * 10
        return geometry.size.width - offset
    }
    
    /// Return the CardViews frame offset for the given offset in the array
    /// - Parameters:
    ///   - geometry: The geometry proxy of the parent
    ///   - id: The ID of the current user
    private func getCardOffset(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        return  CGFloat(businesses.count - 1 - id) * 10
    }
    
//    private var maxID: Int {
//        return self.businesses.map { $0.id }.max() ?? 0
//    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                LinearGradient(gradient: Gradient(colors: [Color.init(#colorLiteral(red: 0.8509803922, green: 0.6549019608, blue: 0.7803921569, alpha: 1)), Color.init(#colorLiteral(red: 1, green: 0.9882352941, blue: 0.862745098, alpha: 1))]), startPoint: .bottom, endPoint: .top)
                    .frame(width: geometry.size.width * 3, height: geometry.size.height)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .offset(x: -geometry.size.width / 4, y: -geometry.size.height / 2)
                
                VStack(alignment: .center, spacing: 24) {
                    ZStack {
                        ForEach(self.businesses, id: \.self) { business in
                            Group {
                                // Range Operator
                                //if (self.maxID - 3)...self.maxID ~= business.id {
                                CardView(trip: trip, business: business, onRemove: { removedBusiness in
                                        // Remove that user from our array
                                        self.businesses.removeAll { $0.id == removedBusiness.id }
                                    })
                                        //.frame(width: self.getCardWidth(geometry, id: 4), height: 400)
                                        //.offset(x: 0, y: self.getCardOffset(geometry, id: 50))
                                //}
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
        .onAppear {
            getEvents(location: trip.place)
        }
    }
}


struct TinderStackView_Previews: PreviewProvider {
    static var previews: some View {
    TinderStackView(trip: Trip(place: "San Diego", businesses: []), businesses: [Business(
        id: "WavvLdfdP6g8aZTtbBQHTw",
        image_url: URL(string: "https://s3-media4.fl.yelpcdn.com/bphoto/NCYnviylsCnQ5MUpAbabRg/o.jpg")!,
        name: "Gary Danko",
        price: "$$$$",
        rating: 4.5,
        review_count: 5296,
        url: "https://www.yelp.com/biz/gary-danko-san-francisco?adjust_creative=wpr6gw4FnptTrk1CeT8POg&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_lookup&utm_source=wpr6gw4FnptTrk1CeT8POg")])
    }
}
