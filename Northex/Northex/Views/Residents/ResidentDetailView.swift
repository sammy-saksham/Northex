//
//  ResidentDetailView.swift
//  Northex
//
//  Created by Saksham Jain on 16/05/22.
//

import SwiftUI

struct residentDetailView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @FetchRequest(sortDescriptors: [])  var cars: FetchedResults<Car>
    
    var resident: Resident
    
    @State var name: String
    @State var flat: Int16
    @State var floor: Int16
    @State var covid: Bool
    @State var dob: Date
    @State var phone: String
    
    var body: some View {
        
        return VStack {
            Form {
                Image(systemName: "person.crop.square.filled.and.at.rectangle.fill")
                    .resizable()
                    .frame(width: 300, height: 220, alignment: .center)
                    .foregroundColor(Color.gray)
                
                TextField("Name", text: $name)
                Stepper("House Number: \(flat)", value: $flat, in: 0...100)
                Stepper("Floor Number: \(floor)", value: $floor, in: 0...4)
                TextField("Phone Number", text: $phone).keyboardType(.phonePad)
                DatePicker("Birth Date", selection: $dob, displayedComponents: [.date])
                Toggle(isOn: $covid) {
                    Text("Covid Positive")
                }
                .tint(.red)
                VStack(alignment: .leading) {
                    Text("Cars:")
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(cars) { car in
                                if(car.flatNumber == resident.flatNumber && car.floorNumber == resident.floorNumber) {
                                    Text(car.registrationNumber ?? "Unknown")
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarItems(trailing:
                                    Button(action: {
                resident.name = name
                resident.flatNumber = Int16(flat)
                resident.floorNumber = Int16(floor)
                resident.isCovidPositive = covid
                resident.birthDate = dob
                resident.phoneNumber = phone
                
                UINotificationFeedbackGenerator().notificationOccurred(.success)
                
                presentationMode.wrappedValue.dismiss()
                
                try? managedObjectContext.save()
            }, label: {
                Image(systemName: "person.fill.checkmark")
                    .foregroundColor(.green)
            })
            )
            
        }
    }
}

//struct residentDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        residentDetailView()
//    }
//}

