//
//  DieImageView.swift
//  SevenWondersDice
//
//  Displays a single die image with proper corner radius
//

import SwiftUI

struct DieImageView: View {
    let die: Die
    var maxSize: CGFloat? = nil

    var cornerRadius: CGFloat {
        // Typical die corner radius is about 12-15% of the die size
        if let size = maxSize {
            return size * 0.13
        }
        return 8 // Fallback for when size isn't specified
    }

    var body: some View {
        Image(die.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: maxSize, maxHeight: maxSize)
                .cornerRadius(cornerRadius)
                .shadow(radius: 2)
    }
}

#Preview {
    DieImageView(
        die: Die(color: .blue, faceIndex: 0, gridRow: 0, gridCol: 0),
        maxSize: 100
    )
}
