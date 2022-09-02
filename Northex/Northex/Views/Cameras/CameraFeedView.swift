//
//  CameraFeedView.swift
//  Northex
//
//  Created by Saksham Jain on 10/06/22.
//

import SwiftUI

struct CameraFeedView: View {
    var body: some View{
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.gray)
                    .frame(width: 160, height: 110, alignment: .center)
                Image(systemName: "video.and.waveform")
                    .resizable()
                    .frame(width: 70, height: 50, alignment: .center)
                    .foregroundColor(.white)
            }
            
            Text("Live Camera Feed")
                .font(.callout)
        }
    }
}

struct CameraFeedView_Previews: PreviewProvider {
    static var previews: some View {
        CameraFeedView()
    }
}
