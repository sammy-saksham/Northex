//
//  AddCarView.swift
//  Northex
//
//  Created by Saksham Jain on 16/05/22.
//

import SwiftUI
import AVFoundation

struct AddCarView: View {
    @Binding var isShowing: Bool
    
    let generator = UINotificationFeedbackGenerator()
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [])  var cars: FetchedResults<Car>
    @FetchRequest(sortDescriptors: []) var owners: FetchedResults<Resident>
    
    var floors = [0, 1, 2, 3, 4]
    
    @State private var color: String = ""
    @State private var flat: Int = 0
    @State private var floor: Int = 0
    @State private var name: String = ""
    @State private var registration: String = ""
    @State private var exitKey: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Name", text: $name)
                    Stepper("House Number: \(flat)", value: $flat, in: 0...100)
                    Stepper("Floor Number: \(floor)", value: $floor, in: 0...4)
                    Picker("Colour", selection: $color) {
                        Text("White").tag("White").textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("Black").tag("Black").textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("Gray").tag("Gray").textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("Blue").tag("Blue").textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("Red").tag("Red").textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    TextField("Registration Number", text: $registration)
                    TextField("Exit Key", text: $exitKey)
                        .keyboardType(.numberPad)
                    
                    if(flat != 0 && floor != 0) {
                        VStack(alignment: .leading) {
                            Text("Owners:")
                                .foregroundColor(.gray)
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(owners) { owner in
                                        if(owner.flatNumber == flat && owner.floorNumber == floor) {
                                            OwnerItemView(owner: owner)
                                                .padding()
                                                .frame(width: 90, height: 90, alignment: .center)
                                                .background(owner.isCovidPositive ? .red : .gray)
                                                .cornerRadius(12)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                Spacer()

            }
            .navigationTitle("Add Car")
            .navigationBarItems(trailing:
                Button {
                    if(name != "" && flat != 0 && floor != 0 && color != "" && registration != "" && exitKey != "") {
                        let car = Car(context: managedObjectContext)
                        car.name = name
                        car.flatNumber = Int16(flat)
                        car.floorNumber = Int16(floor)
                        car.color = color
                        car.registrationNumber = registration.uppercased()
                        car.exitKey = exitKey
                        car.isParked = false
                                            
                        try? managedObjectContext.save()
                    
                        generator.notificationOccurred(.success)

                        isShowing.toggle()
                    }
                } label: {
                    Image(systemName: "square.and.arrow.down.on.square.fill")
                        .foregroundColor((name != "" && flat != 0 && floor != 0 && color != "" && registration != "" && exitKey != "") ? .green : .gray)
                }
            )
            .navigationBarItems(leading:
                Button(action: {
                    isShowing.toggle()
                }, label: {
                    Text("Cancel")
                        .foregroundColor(.red)
                })
            )
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

//struct AddCarView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCarView()
//    }
//}
