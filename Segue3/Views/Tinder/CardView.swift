//
//  CardView.swift
//  Segue3
//
//  Created by Lily Tran on 8/15/22.
//

import SwiftUI

struct CardView: View {
    @State private var translation: CGSize = .zero
    @State private var swipeStatus: LikeDislike = .none
    @ObservedObject var trip: Trip
    @ObservedObject var persist = TripController()
    private var business: Business
    //private var user: User
    private var onRemove: (_ business: Business) -> Void
    
    private var thresholdPercentage: CGFloat = 0.5
    
    private enum LikeDislike: Int {
        case like, dislike, none
    }
    
    init(trip: Trip, business: Business, onRemove: @escaping (_ business: Business) -> Void) {
        self.trip = trip
        self.business = business
        self.onRemove = onRemove
    }
    
    /// What percentage of our own width have we swipped
    /// - Parameters:
    ///   - geometry: The geometry
    ///   - gesture: The current gesture translation value
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                ZStack(alignment: self.swipeStatus == .like ? .topLeading : .topTrailing) {
                    // --get Image from URL----------------------------------------
                    AsyncImage(
                        url: self.business.image_url, content: { phase in
                            switch phase {
                            case .empty: ProgressView()
                            case .success(let image):
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: geometry.size.width, height: geometry.size.height * 0.75)
                                    .clipped()
                                
                                
                            case .failure: Text("Could not load image D:")
                                //print("error in AsyncImage \(error) -> \(error.localDescription)")
                                
                            @unknown default:
                                fatalError()
                            }
                        }
                    )

                    if self.swipeStatus == .like {
                        
                        
                        Text("LIKE")
                            .font(.headline)
                            .padding()
                            .cornerRadius(10)
                            .foregroundColor(Color.green)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.green, lineWidth: 3.0)
                            
                        ).padding(24)
                            .rotationEffect(Angle.degrees(-45))
                    } else if self.swipeStatus == .dislike {
                        Text("DISLIKE")
                            .font(.headline)
                            .padding()
                            .cornerRadius(10)
                            .foregroundColor(Color.red)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.red, lineWidth: 3.0)
                        ).padding(.top, 45)
                            .rotationEffect(Angle.degrees(45))
                    }
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("\(self.business.name)")
                            .font(.title)
                            .bold()
                        Text(self.business.price ?? "")
                            .font(.subheadline)
                            .bold()
//                        Text(self.business.rating)
//                            .font(.subheadline)
//                            .foregroundColor(.gray)
                    }
                    Spacer()
                    
                    Image(systemName: "info.circle")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .offset(x: self.translation.width, y: 0)
            .rotationEffect(.degrees(Double(self.translation.width / geometry.size.width) * 25), anchor: .bottom)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.translation = value.translation
                        
                        if (self.getGesturePercentage(geometry, from: value)) >= self.thresholdPercentage {
                            self.swipeStatus = .like
                            
                        } else if self.getGesturePercentage(geometry, from: value) <= -self.thresholdPercentage {
                            self.swipeStatus = .dislike
                        } else {
                            self.swipeStatus = .none
                        }
                        
                }.onEnded { value in
                    // determine snap distance > 0.5 aka half the width of the screen
                    if self.swipeStatus == .like {
                        persist.addBusiness(trip: trip, business: business)
                    }
                        if abs(self.getGesturePercentage(geometry, from: value)) > self.thresholdPercentage {
                            self.onRemove(self.business)
                        } else {
                            self.translation = .zero
                        }
                    }
            )
        }
    }
}

// 7
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(trip: Trip(place: "San Diego", businesses: []), business: Business(
            id: "WavvLdfdP6g8aZTtbBQHTw",
            image_url: URL(string: "https://s3-media4.fl.yelpcdn.com/bphoto/NCYnviylsCnQ5MUpAbabRg/o.jpg")!,
            name: "Gary Danko",
            price: "$$$$",
            rating: 4.5,
            review_count: 5296,
            url: "https://www.yelp.com/biz/gary-danko-san-francisco?adjust_creative=wpr6gw4FnptTrk1CeT8POg&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_lookup&utm_source=wpr6gw4FnptTrk1CeT8POg"),
            onRemove: { _ in
                    // do nothing
            })
            .frame(height: 400)
            .padding()
    }
}
