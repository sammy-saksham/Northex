//
//  CarItemView.swift
//  Northex
//
//  Created by Saksham Jain on 16/05/22.
//

import SwiftUI

struct CarItemView: View {
    let car: Car
    
    var body: some View {
        HStack(spacing: 12) {
            if(car.isParked) {
                Image(systemName: "car.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .center)
            } else {
                Image(systemName: "car.circle")
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .center)
            }
            
            
            VStack(alignment: .leading) {
                Text(car.name ?? "Unknown")
                    .foregroundColor(.primary)
                    .font(.title2)
                    .fontWeight(.medium)
                Text(car.registrationNumber ?? "Unknown")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("House \(car.flatNumber)")
                Text("Floor \(car.floorNumber)")
            }
            .foregroundColor(Color.secondary)
            .font(.caption)
        }
    }
}

//struct CarItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        CarItemView()
//    }
//}

