//
//  AddResidentView.swift
//  Northex
//
//  Created by Saksham Jain on 16/05/22.
//

import SwiftUI

struct addResidentView: View {
    @Binding var isShowing: Bool
    
    let generator = UINotificationFeedbackGenerator()
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [])  var residents: FetchedResults<Resident>
    
    var floors = [0, 1, 2, 3, 4]
    
    @State private var name: String = ""
    @State private var flat: Int = 0
    @State private var floor: Int = 0
    @State private var birthDate: Date = Date.now
    @State private var phone: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Name", text: $name)
                    Stepper("House Number: \(flat)", value: $flat, in: 0...100)
                    Stepper("Floor Number: \(floor)", value: $floor, in: 0...4)
                    DatePicker("Birth Date", selection: $birthDate, displayedComponents: [.date])
                    TextField("Phone Number", text: $phone)
                        .keyboardType(.phonePad)
                }
                
                Spacer()

            }
            .navigationTitle("Add Car")
            .navigationBarItems(trailing:
                Button {
                    if (name != "" && flat != 0 && floor != 0) {
                        let resident = Resident(context: managedObjectContext)
                        resident.name = name
                        resident.flatNumber = Int16(flat)
                        resident.floorNumber = Int16(floor)
                        resident.birthDate = birthDate
                        resident.isCovidPositive = false
                        resident.phoneNumber = phone
                                            
                        try? managedObjectContext.save()
                    
                        generator.notificationOccurred(.success)
                    
                        isShowing.toggle()
                    }
                } label: {
                    Image(systemName: "person.fill.checkmark")
                        .foregroundColor((name != "" && flat != 0 && floor != 0) ? .green : .gray)
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

//struct addResidentView_Previews: PreviewProvider {
//    static var previews: some View {
//        addResidentView()
//    }
//}
