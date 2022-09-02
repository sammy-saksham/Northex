//
//  OwnerItemView.swift
//  Northex
//
//  Created by Saksham Jain on 16/05/22.
//

import SwiftUI

struct OwnerItemView: View {
    var owner: Resident
    
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .foregroundColor(.white)
            
            Text(owner.name ?? "Unknown")
                .bold()
                .foregroundColor(.white)
                .font(.caption)
        }
    }
}

//struct OwnerItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        OwnerItemView()
//    }
//}
