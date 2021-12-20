//
//  ThumbmailImageView.swift
//  CodingChallenge
//  Toolchain Swift version: 5.0
//
//  Created by Alex Kiselov on 12/19/21.
//  Vamrad LLC
//	www.vamrad.com
//
//  
//
//  

import SwiftUI

struct ThumbmailImageView: View {
    var url: URL?
    var body: some View {
        AsyncImage(url: url) { phase in
            if let image = phase.image {
                image
                    .eventImageModifier()
                    .unredacted()
            } else if phase.error != nil {
                Image(systemName: "photo.artframe")
                    .iconModifier()
                    .redacted(reason: .placeholder)
            } else {
                Image(systemName: "photo.artframe")
                    .iconModifier()
                    .redacted(reason: .placeholder)
            }
        }
    }
}

struct ThumbmailImageView_Previews: PreviewProvider {
    static var previews: some View {
        ThumbmailImageView()
    }
}
