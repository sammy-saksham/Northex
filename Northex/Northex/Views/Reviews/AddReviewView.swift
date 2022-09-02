//
//  AddReviewView.swift
//  Northex
//
//  Created by Saksham Jain on 17/05/22.
//

import SwiftUI
import NaturalLanguage

struct AddReviewView: View {
    @Binding var isShowing: Bool
    
    let generator = UINotificationFeedbackGenerator()
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(keyPath: \Resident.flatNumber, ascending: true),
        NSSortDescriptor(keyPath: \Resident.floorNumber, ascending: true)
    ]) var residents: FetchedResults<Resident>
    
    @State private var name: String = ""
    @State private var flat: Int = 0
    @State private var floor: Int = 0
    @State private var reviewComment: String = ""
    @State private var attention: Bool = false
    @State private var markCritical: Bool = false
    @State private var anonymity: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section("Reviewer's Information") {
                        HStack {
                            Spacer()
                            Button {
                                    withAnimation {
                                        anonymity.toggle()
                                    }
                                } label: {
                                    Text(anonymity ? "Go Identifiable" : "Go Anonymous")
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }
                            Spacer()
                        }
                        .padding(.vertical, 8.0)
                        .background(anonymity ? Color.green : Color.red)
                        .cornerRadius(10)
                        
                            
                        
                            if(!anonymity) {
                                TextField("Name", text: $name)
                                Stepper("House Number: \(flat)", value: $flat, in: 0...100)
                                Stepper("Floor Number: \(floor)", value: $floor, in: 0...4)
                        }
                    }
                    
                    Section("Review") {
                        TextEditor(text: $reviewComment)
                            .frame(height: 150, alignment: .topLeading)
                    }
                    
                    Section("Critical") {
                        Toggle(isOn: $markCritical) {
                            Text("Needs Attention")
                        }
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Add Review")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                if(reviewComment != "") {
                    let review = Review(context: managedObjectContext)
                    review.text = reviewComment
                    review.checked = false
                    review.action = ""
                    review.isResident = false
                    
                    if (!anonymity) {
                        review.reviewer = name
                        review.flatNumber = Int16(flat)
                        review.floorNumber = Int16(floor)
                        
                        for index in 0..<residents.count {
                            if(residents[index].flatNumber == flat && residents[index].floorNumber == floor && residents[index].name == name) {
                                review.isResident = true
                            }
                        }
                    }
                    
                    if(markCritical) {
                        review.requiredAttention = 1
                    } else {
                        review.requiredAttention = Int16((Double(analyzeSentiment(for: reviewComment)) ?? 0) * -1)
                    }
                    
                    try? managedObjectContext.save()
                    
                    generator.notificationOccurred(.success)

                    isShowing.toggle()
                }
            }, label: {
                Image(systemName: "checkmark.rectangle.portrait.fill")
                    .foregroundColor((reviewComment != "") ? Color.blue : Color.gray)
            })
            )
        }
    }
    
    private let tagger = NLTagger(tagSchemes: [.sentimentScore])
    private func analyzeSentiment(for stringToAnalyze: String) -> String {
        tagger.string = stringToAnalyze
        
        let (sentimentScore, _) = tagger.tag(at: stringToAnalyze.startIndex, unit: .paragraph, scheme: .sentimentScore)
        
        return sentimentScore?.rawValue ?? ""
    }
}

struct AddReviewView_Previews: PreviewProvider {
    static var previews: some View {
        AddReviewView(isShowing: .constant(true))
    }
}
