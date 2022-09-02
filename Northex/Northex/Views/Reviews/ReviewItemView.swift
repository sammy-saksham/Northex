//
//  ReviewItemView.swift
//  Northex
//
//  Created by Saksham Jain on 27/05/22.
//

import SwiftUI

struct ReviewItemView: View {
    var review: Review
    
    @State private var reloader: Bool = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                if(review.checked) {
                    Text(review.text ?? "Unknown")
                        .font(.title3)
                        .strikethrough()
                        .fontWeight(.semibold)
                        .lineLimit(1)
                } else {
                    Text(review.text ?? "Unknown")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    
                    Text(review.reviewer ?? "Anonymous Reviewer")
                        .font(.caption)
                    
                    if(review.flatNumber != 0 && review.floorNumber != 0) {
                        HStack {
                            Text("House No. \(review.flatNumber)")
                            Text("-")
                            Text("Floor \(review.floorNumber)")
                        }
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    }
                }
            }
            
            Spacer()
            
            VStack {
                Image(systemName: review.requiredAttention > 0 ? "exclamationmark.circle.fill" : "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20, alignment: .center)
                    .foregroundColor(review.requiredAttention > 0 ? Color.red : Color.green)
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20, alignment: .center)
                    .foregroundColor(.yellow)
                    .opacity(review.isResident ? 1 : 0)
            }
        }
    }
}

//struct ReviewItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewItemView()
//    }
//}
