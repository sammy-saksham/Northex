//
//  CarListView.swift
//  Northex
//
//  Created by Saksham Jain on 16/05/22.
//

import SwiftUI

struct CarListView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(keyPath: \Car.flatNumber, ascending: true),
        NSSortDescriptor(keyPath: \Car.floorNumber, ascending: true)
    ]) var cars: FetchedResults<Car>
    @FetchRequest(sortDescriptors: []) var owners: FetchedResults<Resident>
    
    @State private var showAddCarSheet: Bool = false
    @State private var searchText: String = ""
    
    @State private var covidAlertShowing: Bool = false
    @State private var cameraAlertShowing: Bool = false
    
    var body: some View {
        VStack {
            List {
                ForEach(searchResults, id: \.self) { car in
                    if(car.isParked) {
                        NavigationLink {
                            CarExitView(car: car)
                        } label: {
                            CarItemView(car: car)
                        }
                        .onTapGesture {
                            for owner in owners {
                                if (owner.flatNumber == car.flatNumber && owner.floorNumber == car.floorNumber && owner.isCovidPositive) {
                                    covidAlertShowing = true
                                    break
                                }
                            }
                        }
                    } else {
                        CarItemView(car: car)
                            .onTapGesture {
                                car.isParked = true
                                
                                try? managedObjectContext.save()
                            }
                    }
                    
                }
                .onDelete(perform: removeCar)
                .alert(isPresented: $covidAlertShowing) {
                    Alert(title: Text("Covid Alert"), message: Text("One or more owners of this car have been infected. Kindly take caution!"), dismissButton: .destructive(Text("OK")))
                }
            }
            .searchable(text: $searchText)
            .frame(alignment: .leading)
        }
        .navigationTitle("Parking")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
                                HStack {
            Button(action: {
                cameraAlertShowing.toggle()
                }, label: {
                    Image(systemName: "camera.metering.none")
            })
            
            Button {
                showAddCarSheet.toggle()
            } label: {
                Image(systemName: "plus")
            }
            
        }
        )
        .sheet(isPresented: $showAddCarSheet) {
            AddCarView(isShowing: $showAddCarSheet)
        }
        .alert(isPresented: $cameraAlertShowing) {
            Alert(title: Text("Cannot Launch Camera"), message: Text("The camera on this device is not responding. Kindly restart the device or contact your nearest Apple Authorized Service Centre."), dismissButton: .destructive(Text("OK")))
        }
    }
    
    var searchResults: Array<Car> {
        if searchText.isEmpty {
            return cars.filter { carItem -> Bool in
                return true
            }
        } else {
            return cars.filter { carItem -> Bool in
                return (carItem.registrationNumber?.contains(searchText) ?? false) || (carItem.name?.contains(searchText) ?? false)
            }
        }
    }
    
    func removeCar(at offsets: IndexSet) {
        for index in offsets {
            let car = cars[index]
            managedObjectContext.delete(car)
        }
        
        try? managedObjectContext.save()
    }
}

struct CarListView_Previews: PreviewProvider {
    static var previews: some View {
        CarListView()
    }
}

