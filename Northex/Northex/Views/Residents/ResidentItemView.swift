//
//  ResidentItemView.swift
//  Northex
//
//  Created by Saksham Jain on 16/05/22.
//

import SwiftUI

struct residentItemView: View {
    @ObservedObject var resident: Resident
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: []) var cars: FetchedResults<Car>
    
    var body: some View {
        HStack(spacing: 12) {
            if(!resident.isCovidPositive) {
                Image(systemName: "person.crop.circle.badge.checkmark")
                    .symbolRenderingMode(.palette)
                    .resizable()
                    .foregroundStyle(.green, .primary)
                    .frame(width: 50, height: 40, alignment: .center)
            } else {
                Image(systemName: "person.crop.circle.badge.xmark")
                    .symbolRenderingMode(.palette)
                    .resizable()
                    .foregroundStyle(.red, .primary)
                    .frame(width: 50, height: 40, alignment: .center)
            }
            
            
            VStack(alignment: .leading) {
                Text(resident.name ?? "Unknown")
                    .foregroundColor(.primary)
                    .font(.title2)
                    .fontWeight(.medium)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("House \(resident.flatNumber)")
                Text("Floor \(resident.floorNumber)")
            }
            .foregroundColor(Color.secondary)
            .font(.caption)
        }
    }
}

//struct residentItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        residentItemView()
//    }
//}
