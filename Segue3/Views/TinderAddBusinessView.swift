//
//  TinderAddBusinessView.swift
//  Segue3
//
//  Created by Lily Tran on 8/12/22.
//

import SwiftUI

struct TinderAddBusinessView: View {
    @ObservedObject private var bvm = BusinessViewModel(place: "Italy")
    private var persist = TripController.shared
    
    var body: some View {
        
        ZStack(alignment: .trailing){
            Text("you have reached the end!")
            
            ForEach(bvm.businesses) { business in
                TinderCardView(business: business)
                
            }
            
            
        }
        if bvm.businesses.isEmpty {
            ProgressView()
        }
        //.navigationTitle("Events")
    }
    
}

struct TinderAddBusinessView_Previews: PreviewProvider {
    static var previews: some View {
        TinderAddBusinessView()
    }
}

class BusinessViewModel: ObservableObject {
    var place: String
    @Published var businesses: [Business] = []
    @Published var businessImage: UIImage = ((UIImage(systemName: "circle") ?? UIImage(systemName: "square"))!)
    
    init(place: String) {
        self.place = place
        DispatchQueue.main.async {
            self.getEvents(location: place)
        }
    }

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

struct TinderCardView: View {
    var business: Business
    @State private var offset = CGSize.zero
    @State private var fontSize: CGFloat = 20
    @State private var width: CGFloat = UIScreen.screenWidth - 25
    @State private var objectHeight: CGFloat = UIScreen.screenHeight/2 + 100
    @State private var textFrameHeight: CGFloat = 100

    var body: some View {
        ZStack(alignment: .bottom) {
            
            // --get Image from URL----------------------------------------
            AsyncImage(
                url: business.image_url, content: { phase in
                    switch phase {
                    case .empty: ProgressView()
                    case .success(let image):
                        image.resizable()
                            .frame(width: width, height: objectHeight, alignment: .center)
                            .aspectRatio(contentMode: .fill)
                        
                        
                    case .failure: Text("Could not load image D:")
                        //print("error in AsyncImage \(error) -> \(error.localDescription)")
                        
                    @unknown default:
                        fatalError()
                    }
                }
            )
            // --get business information----------------------------------
            VStack(alignment: .center, spacing: 1) {
                Text(business.name)
                //Text(business.review_count)
                Text(business.price ?? "no pricing info")
//                ForEach(business.categories) { category in
//                    Text(category)
//                }
            }
            .frame(width: UIScreen.screenWidth - 25, height: 100, alignment: .center)
            .background(.ultraThickMaterial)
            // --get business information----------------------------------
            
        }
        .border(.ultraThickMaterial, width: 15)
        //.font(.system(size: fontSize, weight: .heavy, design: .rounded))
        .font(.custom("Baskerville", size: fontSize))
        
        
        .offset(x: offset.width, y: offset.height * 0.4)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .gesture( DragGesture()
            .onChanged { gesture in
                offset = gesture.translation
            } .onEnded { _ in
                swipeCard(width: offset.width)
            }
                  
        )
        
        
    }
    
    func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-150):
            print("\(business.name) event removed")
            offset = CGSize(width: -500, height: 0)
        case 150...500:
            print("\(business.name) added")
            offset = CGSize(width: 500, height: 0)
        default:
            offset = .zero
        }
    }
}
// to get the screen size
extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

