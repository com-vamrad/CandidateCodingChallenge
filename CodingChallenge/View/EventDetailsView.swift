//
//  EventDetails.swift
//  CodingChallenge
//  Toolchain Swift version: 5.0
//
//  Created by Alex Kiselov on 12/18/21.
//  Vamrad LLC
//	www.vamrad.com
//
//  
//
//  

import SwiftUI

struct EventDetailsView: View {
    var event: Event
    @Binding var favIDs: Set<Int>
    // @State var isFav: Bool = false
    var body: some View {
        VStack(alignment: .leading) {
            
            ButtonHeartView(event: event, favIDs: $favIDs)
            DetailImageView(url: event.performers.first?.image)
            
            Text(event.datetimeLocal.eventTimestamp())
                .eventDetailsDateModifier()
            Text(event.venue.cityState())
                .eventDetailsCityModifier()
            Spacer()
        }.padding()
        
        
    }
}

extension Text {
    
    func eventDetailsDateModifier() -> some View {
        self
            .eventDetailsTitleModifier()
            .lineLimit(1)
            .allowsTightening(true)
            .minimumScaleFactor(0.8)
            .padding(.top, 20)
    }
    
    func eventDetailsCityModifier() -> some View {
        self
            .font(.title2)
            .foregroundColor(Color("EventSubTitle"))
    }
}




struct EventDetails_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailsView(event: Event(id: 1, title: "Veronica Swift and the Emmet Cohen Trio", datetimeLocal: Date(), performers: [], venue: Venue(id: 4, city: "Buffalo", state: "NY")), favIDs: .constant(Set<Int>()))
    }
}
