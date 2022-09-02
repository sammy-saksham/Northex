//
//  CarExitView.swift
//  Northex
//
//  Created by Saksham Jain on 16/05/22.
//

import SwiftUI

struct CarExitView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @FetchRequest(sortDescriptors: []) var owners: FetchedResults<Resident>
    
    let car: Car
    
    @State private var key: String = ""
    @State private var invalidAlertShowing: Bool = false
    @State private var covidAlertShowing: Bool = false
    
    var body: some View {
        return NavigationView {
            VStack {
                Image(systemName: "car.circle")
                    .resizable()
                    .frame(width: 150, height: 150, alignment: .center)
                
                Text(car.name ?? "Unknown")
                    .font(.title)
                    .bold()
                
                Text(car.registrationNumber ?? "Unknown")
                    .font(.title2)
                
                TextField("Enter Exit Key", text: $key)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300, height: 40, alignment: .center)
                    .keyboardType(.numberPad)
                
                Spacer()
                
                Button {
                    if (key == car.exitKey) {
                        car.isParked = false
                        key = ""
                        
                        presentationMode.wrappedValue.dismiss()
                        
                        try? managedObjectContext.save()
                    } else {
                        key = ""
                        invalidAlertShowing.toggle()
                    }
                } label: {
                    Text("Exit")
                        .frame(width: 300, height: 50, alignment: .center)
                        .background(Color.green)
                        .foregroundColor(Color.white)
                        .cornerRadius(12)
                }
                .alert("Invalid Exit Key", isPresented: $invalidAlertShowing) {
                    Button("OK", role: .cancel) {}
                }
                .alert(isPresented: $covidAlertShowing) {
                    Alert(title: Text("Covid Alert"), message: Text("One or more owners of this car have been infected. Kindly take caution!"), dismissButton: .destructive(Text("OK")))
                }
            }
            .padding()
            .onAppear {
                for owner in owners {
                    if (owner.flatNumber == car.flatNumber && owner.floorNumber == car.floorNumber && owner.isCovidPositive) {
                        covidAlertShowing = true
                        break
                    }
                }
            }
        }
    }
}

//struct CarExitView_Previews: PreviewProvider {
//    static var previews: some View {
//        CarExitView()
//    }
//}
