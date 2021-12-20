//
//  DetailImageView.swift
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

struct DetailImageView: View {
    var url: URL?
    var body: some View {
        AsyncImage(url: url) { phase in
            if let image = phase.image {
                image
                    .eventDetailsImageModifier()
                    .unredacted()
                
            } else if phase.error != nil {
                Image(systemName: "photo.artframe")
                    .eventDetailsIconModifier()
                    .redacted(reason: .placeholder)
            } else {
                Image(systemName: "photo.artframe")
                    .eventDetailsIconModifier()
                    .redacted(reason: .placeholder)
                
            }
        }
    }
}

extension Image {
    func eventDetailsImageModifier() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(.horizontal, 20)
    }
    
    func eventDetailsIconModifier() -> some View {
        self
            .eventDetailsImageModifier()
            .opacity(0.5)
    }
    
    
}

struct DetailImageView_Previews: PreviewProvider {
    static var previews: some View {
        DetailImageView()
    }
}
