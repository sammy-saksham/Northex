//
//  RegistrationView.swift
//  Northex
//
//  Created by Saksham Jain on 16/05/22.
//

import SwiftUI

struct RegistrationView: View {
    var body: some View {
        NavigationView {
            VStack {
                MapView()
                    .ignoresSafeArea()
                    .frame(height: UIScreen.main.bounds.height/3)
                
                Spacer()
                
                NavigationLink {
                    CarListView()
                } label: {
                    HStack {
                        Image(systemName: "car.2.fill")
                        Text("Parking")
                    }
                    .frame(width: 300, height: 60, alignment: .center)
                    .font(.title2)
                    .background(Color.gray)
                    .foregroundColor(Color.white)
                    .cornerRadius(12)
                }
                
                NavigationLink {
                    residentListView()
                } label: {
                    HStack {
                        Image(systemName: "person.3.fill")
                        Text("Residents")
                    }
                    .frame(width: 300, height: 60, alignment: .center)
                    .font(.title2)
                    .background(Color.gray)
                    .foregroundColor(Color.white)
                    .cornerRadius(12)
                }
                
                Spacer()
            }
            .navigationTitle("Northex")
        }

    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
