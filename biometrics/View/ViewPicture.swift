//
//  ViewPicture.swift
//  biometrics
//
//  Created by Philippe MICHEL on 31/03/2024.
//

import SwiftUI
struct ViewPicture: View {
    @Binding var showPicture:Bool
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: showPicture ? Resources.pictures.lock_open.rawValue : Resources.pictures.lock.rawValue)
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
                .aspectRatio(contentMode: .fill)
                .foregroundColor(showPicture ? .gray :.red)
            Image("BBjpg")
                .resizable()
                .frame(width: 250, height: 250, alignment: .center)
                .aspectRatio(contentMode: .fill)
                .blur(radius: showPicture ? 0 : 60)
        }
    }
}

#Preview {
    ViewPicture(showPicture: .constant(true))
}
