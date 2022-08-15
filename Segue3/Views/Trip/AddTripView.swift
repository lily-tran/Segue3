//
//  AddTripView.swift
//  Segue3
//
//  Created by Lily Tran on 8/13/22.
//

import SwiftUI

struct AddTripView: View {
    //let exercise: Exercise
    @ObservedObject var vm = AddTripViewModel()
    @Environment(\.rootPresentation) var rootPresentation: Binding<Bool>
    
    
    var body: some View {
        Form {
            VStack(alignment: .leading, spacing: 2) {
                //Text("Destination")
//TitleText(text: "Add to Workout")

                Text("Add New Trip")
                TextField("City, State", text: $vm.name)
//                Text("Sets: \(Int(vm.sets))")
//                Slider(value: $vm.sets, in: 0...10, step: 1)
//                Text("Reps: \(Int(vm.reps))")
//                Slider(value: $vm.reps, in: 0...25, step: 1)
//                // TODO: add var for kb or lb
//                Text("Maximum Weight: \(Int(vm.weight)) \(vm.metric)")
//                Slider(value: $vm.weight, in: 0...1_000, step: 2)
                Button {
                    if !vm.name.isEmpty {
                        TripController().createTrip(name: vm.name)
                        rootPresentation.wrappedValue = false
                    } else {
                        // present an alert, but for now, we will just do nothing
                        print("no name so cannot add")
                    }
                } label: {
                    Text("Add")
                        // .background(Color.gray)
                        .frame(width: 150, height: 50, alignment: .center)
                        .padding(5)
                        .foregroundColor(.gray)//
                        
                }
            }

            // .background(Color("LightBackground"))
            .clipShape(RoundedRectangle(cornerRadius: 5))
        }
    }
}

struct AddTrpView_Previews: PreviewProvider {
    static var previews: some View {
        AddTripView()
    }
}
class AddTripViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var date: Date = Date()
    @Published var reps: Double = 10
    @Published var weight: Double = 0
    @Published var metric: String = "kg"
}
