//
//  StaticHeartView.swift
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

struct StaticHeartView: View {
    var body: some View {
        HStack(alignment: .top){
            VStack(alignment:.leading) {
                
                Image(systemName: "heart.fill" )
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .foregroundColor(Color("BriefBackground"))
                    .frame(width:28,height:28)
                
                    .overlay(
                        Image(systemName: "heart.fill" )
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .foregroundColor(.red)
                            .frame(width:25,height:25)
                        
                    ).padding(4)
                
                Spacer()
            }
            Spacer()
        }.zIndex(15)
    }
}

struct StaticHeartView_Previews: PreviewProvider {
    static var previews: some View {
        StaticHeartView()
    }
}
