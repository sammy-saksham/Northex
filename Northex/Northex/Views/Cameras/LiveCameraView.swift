//
//  CameraListView.swift
//  Northex
//
//  Created by Saksham Jain on 10/06/22.
//

import SwiftUI

struct LiveCameraView: View {
    @State private var showContextSheet: Bool = false
    
    var body: some View {
        NavigationView {
            VStack() {
                HStack {
                    Spacer()
                    CameraFeedView()
                        .onLongPressGesture {
                            showContextSheet.toggle()
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                        }
                    Spacer()
                    CameraFeedView()
                        .onLongPressGesture {
                            showContextSheet.toggle()
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                        }
                    Spacer()
                }
                .padding(.horizontal)
                HStack {
                    Spacer()
                    CameraFeedView()
                        .onLongPressGesture {
                            showContextSheet.toggle()
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                        }
                    Spacer()
                    CameraFeedView()
                        .onLongPressGesture {
                            showContextSheet.toggle()
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                        }
                    Spacer()
                }
                .padding(.horizontal)
                Spacer()
            }
            .navigationTitle(Text("Camera Feed"))
            .sheet(isPresented: $showContextSheet) {
                CameraContextView()
            }
        }
    }
}

struct CameraListView_Previews: PreviewProvider {
    static var previews: some View {
        LiveCameraView()
    }
}
