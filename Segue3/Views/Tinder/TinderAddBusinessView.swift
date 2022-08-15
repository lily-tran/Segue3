////
////  TinderAddBusinessView.swift
////  Segue3
////
////  Created by Lily Tran on 8/12/22.
////
//
//
//import SwiftUI
//
//struct TinderAddBusinessView: View {
//    @State var businesses: [Business] = []
//    @State var businessImage: UIImage = ((UIImage(systemName: "circle") ?? UIImage(systemName: "square"))!)
//
//    private var persist = TripController()
//
//    var body: some View {
//
//        ZStack(alignment: .trailing){
//            Text("you have reached the end!")
//
//            ForEach(businesses) { business in
//                TinderCardView(business: business)
//
//            }
//
//
//        }
//        .onAppear {
//            DispatchQueue.main.async {
//                self.getEvents(location: place)
//        }
//        if bvm.businesses.isEmpty {
//            ProgressView()
//        }
//        //.navigationTitle("Events")
//    }
//
//
//
//    func getEvents(location: String) {
//        YelpFusionController.fetchYelpRequsts(location: location) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let events):
//                    self.businesses = events
//                case .failure(let error):
//                    print("There was an error with call to fetchEvents(): \(error.localizedDescription) -> \(error)")
//                                    }
//            }
//        }
//
//    }
//
//}
//
//struct TinderAddBusinessView_Previews: PreviewProvider {
//    static var previews: some View {
//        TinderAddBusinessView()
//    }
//}
//
//
//struct TinderCardView: View {
//    var business: Business
//    @State private var offset = CGSize.zero
//    @State private var fontSize: CGFloat = 20
//    @State private var width: CGFloat = UIScreen.screenWidth - 25
//    @State private var objectHeight: CGFloat = UIScreen.screenHeight/2 + 100
//    @State private var textFrameHeight: CGFloat = 100
//
//    var body: some View {
//        ZStack(alignment: .bottom) {
//
//            // --get Image from URL----------------------------------------
//            AsyncImage(
//                url: business.image_url, content: { phase in
//                    switch phase {
//                    case .empty: ProgressView()
//                    case .success(let image):
//                        image.resizable()
//                            .frame(width: width, height: objectHeight, alignment: .center)
//                            .aspectRatio(contentMode: .fill)
//
//
//                    case .failure: Text("Could not load image D:")
//                        //print("error in AsyncImage \(error) -> \(error.localDescription)")
//
//                    @unknown default:
//                        fatalError()
//                    }
//                }
//            )
//            // --get business information----------------------------------
//            VStack(alignment: .center, spacing: 1) {
//                Text(business.name)
//                //Text(business.review_count)
//                Text(business.price ?? "no pricing info")
////                ForEach(business.categories) { category in
////                    Text(category)
////                }
//            }
//            .frame(width: UIScreen.screenWidth - 25, height: 100, alignment: .center)
//            .background(.ultraThickMaterial)
//            // --get business information----------------------------------
//
//        }
//        .border(.ultraThickMaterial, width: 15)
//        //.font(.system(size: fontSize, weight: .heavy, design: .rounded))
//        .font(.custom("Baskerville", size: fontSize))
//
//
//        .offset(x: offset.width, y: offset.height * 0.4)
//        .rotationEffect(.degrees(Double(offset.width / 40)))
//        .gesture( DragGesture()
//            .onChanged { gesture in
//                offset = gesture.translation
//            } .onEnded { _ in
//                swipeCard(width: offset.width)
//            }
//
//        )
//
//
//    }
//
//    func swipeCard(width: CGFloat) {
//        switch width {
//        case -500...(-150):
//            print("\(business.name) event removed")
//            offset = CGSize(width: -500, height: 0)
//        case 150...500:
//            print("\(business.name) added")
//            offset = CGSize(width: 500, height: 0)
//        default:
//            offset = .zero
//        }
//    }
//}
//// to get the screen size
//extension UIScreen{
//    static let screenWidth = UIScreen.main.bounds.size.width
//    static let screenHeight = UIScreen.main.bounds.size.height
//    static let screenSize = UIScreen.main.bounds.size
//}
//
//
//
//
//import SwiftUI
//
//struct TinderAddBusinessView: View {
//    @ObservedObject var trip: Trip
//
//    @State var businesses: [Business] = []
//    @State var businessImage: UIImage = ((UIImage(systemName: "circle") ?? UIImage(systemName: "square"))!)
//
//    @State private var offset: CGSize = .zero
//
//
//
//    //var place: String = trip.place
//    //@ObservedObject private var bvm = TinderBusinessViewModel(place: place)
//    // private var persist = TripController.shared
//
//    var body: some View {
//
//        ZStack(alignment: .trailing){
//            Text("you have reached the end!")
//
//            ForEach(businesses) { business in
//                TinderCardViewModel(trip: trip, business: business)
//            }
//
//
//        }
//        .offset(x: offset.width, y: offset.height * 0.4)
//        .rotationEffect(.degrees(Double(offset.width / 40)))
//        .gesture( DragGesture()
//            .onChanged { gesture in
//                offset = gesture.translation
//                if Array(150...500).contains(Int(offset.width)) {
//                    persist.addBusiness(trip: trip, business: business)
//                }
//            } .onEnded { _ in
//                swipeCard(width: offset.width)
//
//            }
//
//        )
//
//        .onAppear{
//            getEvents(location: trip.place)
//        }
//        if businesses.isEmpty {
//            ProgressView()
//        }
//        //.navigationTitle("Events")
//
//
//
//
//
//    }
//
//    func popBusinesses() {
//
//    }
//
//    func swipeCard(width: CGFloat) {
//        switch width {
//        case -500...(-150):
//            print("\(business.name) event removed")
//            offset = CGSize(width: -500, height: 0)
//
//        case 150...500:
//            print("\(business.name) added")
//            offset = CGSize(width: 500, height: 0)
//        default:
//            offset = .zero
//        }
//    }
//
//
//
//}
//
//
//
////struct TinderAddBusinessView_Previews: PreviewProvider {
////    static var previews: some View {
////        TinderAddBusinessView(trip: Trip(place: "San Diego", businesses: []))
////    }
////}
//
//
//struct TinderCardViewModel: View {
//
//    @State var trip: Trip
//    @State var business: Business
//    @State private var fontSize: CGFloat = 20
//    @State private var width: CGFloat = UIScreen.screenWidth - 25
//    @State private var objectHeight: CGFloat = UIScreen.screenHeight/2 + 100
//    @State private var textFrameHeight: CGFloat = 100
//
//    @State private var translation: CGSize = .zero
//
//    var body: some View {
//        ZStack(alignment: .bottom) {
//
//            // --get Image from URL----------------------------------------
//            AsyncImage(
//                url: business.image_url, content: { phase in
//                    switch phase {
//                    case .empty: ProgressView()
//                    case .success(let image):
//                        image.resizable()
//                            .frame(width: width, height: objectHeight, alignment: .center)
//                            .aspectRatio(contentMode: .fill)
//
//
//                    case .failure: Text("Could not load image D:")
//                        //print("error in AsyncImage \(error) -> \(error.localDescription)")
//
//                    @unknown default:
//                        fatalError()
//                    }
//                }
//            )
//            // --get business information----------------------------------
//            VStack(alignment: .center, spacing: 1) {
//                Text(business.name)
//                //Text(business.review_count)
//                Text(business.price ?? "no pricing info")
////                ForEach(business.categories) { category in
////                    Text(category)
////                }
//            }
//            .frame(width: UIScreen.screenWidth - 25, height: 100, alignment: .center)
//            .background(.ultraThickMaterial)
//            // --get business information----------------------------------
//
//        }
//        .border(.ultraThickMaterial, width: 15)
//        //.font(.system(size: fontSize, weight: .heavy, design: .rounded))
//        .font(.custom("Baskerville", size: fontSize))
//
//    }
//}
//// to get the screen size
//extension UIScreen{
//    static let screenWidth = UIScreen.main.bounds.size.width
//    static let screenHeight = UIScreen.main.bounds.size.height
//    static let screenSize = UIScreen.main.bounds.size
//}
//
