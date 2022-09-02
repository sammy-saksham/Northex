//
//  ReviewDetailView.swift
//  Northex
//
//  Created by Saksham Jain on 27/05/22.
//

import SwiftUI
import LocalAuthentication

struct ReviewDetailView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    var review: Review
    
    @State var actionTaken: String
    @State var isChecked: Bool
    
    var body: some View {
        List {
            Section("Review") {
                Text(review.text ?? "Unknown")
            }
            
            if(review.reviewer != "") {
                Section("Reviewer Details") {
                    Text(review.reviewer ?? "Unknown")
                    Text("Flat Number: \(review.flatNumber)")
                    Text("Floor: \(review.floorNumber)")
                }
            }
            
            Section("Action") {
                TextField("Action Taken", text: $actionTaken)
                Toggle("Review Completed", isOn: $isChecked)
            }
        }
        .navigationBarTitle("Review Detail")
        .navigationBarItems(trailing: Button(action: {
            review.action = actionTaken
            review.checked = isChecked
            
            UINotificationFeedbackGenerator().notificationOccurred(.success)
                    
            presentationMode.wrappedValue.dismiss()
            
            try? managedObjectContext.save()
        }, label: {
            Image(systemName: "checkmark.seal.fill")
                .foregroundColor(.green)
        }))
        .onAppear(perform: authenticate)
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                if !success {
                    exit(1)
                }
            }
        } else {
            print("Biometrics Not Available")
        }
    }
}
