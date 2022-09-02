//
//  NorthexApp.swift
//  Northex
//
//  Created by Saksham Jain on 16/05/22.
//

import SwiftUI

@main
struct NorthexApp: App {
    @StateObject private var controller = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, controller.container.viewContext)
        }
    }
}
