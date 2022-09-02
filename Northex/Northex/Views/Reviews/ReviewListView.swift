//
//  ReviewView.swift
//  Northex
//
//  Created by Saksham Jain on 17/05/22.
//

import SwiftUI

struct ReviewListView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Review.checked, ascending: false), NSSortDescriptor(keyPath: \Review.isResident, ascending: true), NSSortDescriptor(keyPath: \Review.requiredAttention, ascending: false)]) var reviews: FetchedResults<Review>
    
    @State private var showAddReviewSheet: Bool = false
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchResults, id: \.self) { review in
                    NavigationLink {
                        ReviewDetailView(review: review, actionTaken: review.action ?? "", isChecked: review.checked)
                    } label: {
                        ReviewItemView(review: review)
                    }
                }
                .onDelete(perform: removeReview)
            }
            .searchable(text: $searchText)
            .navigationTitle(Text("Reviews"))
            .navigationBarItems(trailing:
                                    Button(action: {
                showAddReviewSheet.toggle()
            }, label: {
                Image(systemName: "square.and.pencil")
            })
            )
            .sheet(isPresented: $showAddReviewSheet) {
                AddReviewView(isShowing: $showAddReviewSheet)
            }
        }
//        .onAppear {
//            reloader.toggle()
//        }
    }
    
    func removeReview(at offsets: IndexSet) {
        for index in offsets {
            let review = reviews[index]
            managedObjectContext.delete(review)
        }
        
        try? managedObjectContext.save()
    }
    
    var searchResults: Array<Review> {
        if searchText.isEmpty {
            return reviews.filter { reviewItem -> Bool in
                return true
            }
        } else {
            return reviews.filter { reviewItem -> Bool in
                return (reviewItem.text?.contains(searchText) ?? false) || (reviewItem.reviewer?.contains(searchText) ?? false)
            }
        }
    }
}

struct ReviewListView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewListView()
    }
}
