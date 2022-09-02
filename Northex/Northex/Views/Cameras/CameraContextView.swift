//
//  CameraContextView.swift
//  Northex
//
//  Created by Saksham Jain on 10/06/22.
//

import SwiftUI

struct CameraContextView: View {
    var body: some View {
            VStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 350, height: 200, alignment: .center)
                
                HStack {
                    Text("**Live transcription using sound recognition.** \nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                        .font(.callout)
                        .foregroundColor(.gray)
                        .padding()
                    Spacer()
                }
        }
    }
}

struct CameraContextView_Previews: PreviewProvider {
    static var previews: some View {
        CameraContextView()
    }
}
