//
//  ContentView.swift
//  Northex
//
//  Created by Saksham Jain on 16/05/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RegistrationView()
                .tabItem {
                    Label("Parking", systemImage: "car")
                }
            LiveCameraView()
                .tabItem {
                    Label("Camera", systemImage: "video")
                }
            ReviewListView()
                .tabItem {
                    Label("Review", systemImage: "list.star")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

