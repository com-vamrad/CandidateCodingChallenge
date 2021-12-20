//
//  ButtonHeartView.swift
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

struct ButtonHeartView: View {
    var event: Event
    @Binding var favIDs: Set<Int>
    @State private var isFav: Bool = false
    var body: some View {
        HStack(alignment: .top){
            Text(event.title)
                .eventDetailsTitleModifier()
            Spacer()
            Button(action:{
                isFav.toggle()
                if isFav {
                    favIDs.insert(event.id)
                    
                } else {
                    favIDs.remove(event.id)
                }
            } ) {
                Image(systemName: isFav ? "heart.fill" : "heart")
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .foregroundColor(.red)
                    .frame(width:25,height:25)
                    .padding(4)
            }
            
            
        } .onAppear{
            isFav = favIDs.contains(event.id)
        }
    }
}

extension Text {
    func eventDetailsTitleModifier() -> some View {
        self
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(Color("EventTitle"))
    }
}

//struct ButtonHeartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ButtonHeartView()
//    }
//}
