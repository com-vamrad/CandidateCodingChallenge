//
//  EventBriefView.swift
//  CodingChallenge
//  Toolchain Swift version: 5.0
//
//  Created by Alex Kiselov on 12/17/21.
//  Vamrad LLC
//	www.vamrad.com
//
//  
//
//  

import SwiftUI

struct EventBriefView: View {
    var event: Event
    var favIDs: Set<Int>
    var body: some View {
        ZStack{
            Color("BriefBackground")
                .cornerRadius(8)
                .frame(height: 80)
                .shadow(color: Color("BriefShadow"), radius:3, x: 2, y: 2)
            
            if favIDs.contains(event.id) {
                StaticHeartView()
            }
            HStack{
                ThumbmailImageView(url: event.performers.first?.image)
                HStack {
                    VStack(alignment: .leading){
                        Text(event.title)
                            .eventTitleModifier()
                        Text(event.venue.cityState())
                            .eventSubTitleModifier()
                        Text(event.datetimeLocal.eventTimestamp())
                            .eventSubTitleModifier()
                    }
                    Spacer()
                }
            }
            
        }
        
    }
}





extension Text {
    func eventTitleModifier() -> some View {
        self
            .font(.callout)
            .fontWeight(.bold)
            .foregroundColor(Color("EventTitle"))
            .lineLimit(1)
    }
    
    func eventSubTitleModifier() -> some View {
        self
            .font(.footnote)
            .foregroundColor(Color("EventSubTitle"))
            .lineLimit(1)
    }
}

extension Image {
    func eventImageModifier() -> some View {
        self
            .resizable()
            .aspectRatio( contentMode: .fill)
            .frame(width: 60, height: 60, alignment: .center)
            .clipped()
            .cornerRadius(8)
            .padding(.horizontal, 8)
            .padding(.leading, 10)
        
    }
    func iconModifier() -> some View {
        self
            .eventImageModifier()
            .foregroundColor(.gray)
            .opacity(0.5)
    }
}

extension Date {
    func eventTimestamp() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.shortWeekdaySymbols = ["SUN","MON","TUE","WED","THU","FRI","SAT"]
        dateFormatter.dateFormat = "EEE, dd MMM yyyy h:mm a"
        return dateFormatter.string(from: self)
        
    }
}


struct EventBriefView_Previews: PreviewProvider {
    static var previews: some View {
        EventBriefView(event: Event(id: 1, title: "Veronica Swift and the Emmet Cohen Trio", datetimeLocal: Date(), performers: [], venue: Venue(id: 4, city: "Philadelphia", state: "PA")), favIDs: Set<Int>())
    }
}
