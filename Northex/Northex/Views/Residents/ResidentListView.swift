//
//  ResidentListView.swift
//  Northex
//
//  Created by Saksham Jain on 16/05/22.
//

import SwiftUI

struct residentListView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(keyPath: \Resident.flatNumber, ascending: true),
        NSSortDescriptor(keyPath: \Resident.floorNumber, ascending: true)
    ]) var residents: FetchedResults<Resident>
    
    @State private var showAddResidentSheet: Bool = false
    @State private var searchText: String = ""
    
    @State private var showLessThan7DaysAlert: Bool = false
    
    var body: some View {
        VStack {
            List {
                ForEach(searchResults, id: \.self) { resident in
                    NavigationLink {
                        residentDetailView(resident: resident, name: resident.name ?? "", flat: resident.flatNumber, floor: resident.floorNumber, covid: resident.isCovidPositive, dob: resident.birthDate ?? Date.distantPast, phone: resident.phoneNumber ?? "")
                    } label: {
                        residentItemView(resident: resident)
                            .cornerRadius(12)
                    }
                    .contextMenu {
                        VStack {
                            Button {
                                if(Calendar.current.dateComponents([.second], from: resident.infectionDate ?? Date.distantPast, to: Date.now).second ?? 0 < 7 && resident.isCovidPositive) {
                                    showLessThan7DaysAlert.toggle()
                                    resident.isCovidPositive.toggle()
                                    resident.infectionDate = Date.distantPast
                                } else {
                                    resident.isCovidPositive.toggle()
                                    resident.infectionDate = Date.now
                                }
                                
                                try? managedObjectContext.save()
                            } label: {
                                Text("Toggle Covid Status")
                            }
                            
                            Button {
                                let phone = "tel://"
                                let phoneNumberformatted = phone + (resident.phoneNumber ?? "")
                                
                                guard let url = URL(string: phoneNumberformatted) else { return }
                                UIApplication.shared.open(url)
                            } label: {
                                Text("Call \(resident.name ?? "")")
                            }
                            
                            Button {
                                let alert: String = "sms:+91\(resident.phoneNumber ?? "")&body=You have a package waiting for you at the parcel counter. Kindly collect it as soon as possible."
                                let url: String = alert.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                                UIApplication.shared.open(URL.init(string: url)!, options: [:], completionHandler: nil)
                            } label: {
                                Text("Alert Delivery")
                            }


                        }
                    }
                }
                .onDelete(perform: removeResident)
                .alert(isPresented: $showLessThan7DaysAlert) {
                    Alert(title: Text("Premature Recovery"), message: Text("It has been less than 7 days since infection. Please Take Caution"), dismissButton: .destructive(Text("OK")))
                }
            }
            .searchable(text: $searchText)
            .frame(alignment: .leading)
        }
        .navigationTitle("Residents")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
                                Button {
                                    showAddResidentSheet.toggle()
                                } label: {
                                    Image(systemName: "plus")
                                }
        )
        .sheet(isPresented: $showAddResidentSheet) {
            addResidentView(isShowing: $showAddResidentSheet)
        }
    }
    
    var searchResults: Array<Resident> {
        if searchText.isEmpty {
            return residents.filter { resident -> Bool in
                return true
            }
        } else {
            return residents.filter { resident -> Bool in
                return resident.name?.contains(searchText) ?? false
            }
        }
    }
    
    func removeResident(at offsets: IndexSet) {
        for index in offsets {
            let resident = residents[index]
            managedObjectContext.delete(resident)
        }
        
        try? managedObjectContext.save()
    }
}

struct residentListView_Previews: PreviewProvider {
    static var previews: some View {
        residentListView()
    }
}

