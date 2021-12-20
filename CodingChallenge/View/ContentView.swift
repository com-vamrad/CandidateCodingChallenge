//
//  ContentView.swift
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

struct ContentView: View {
    @StateObject var eventManager = EventManager()
    @State var events: [Event] = []
    var body: some View {
        
        NavigationView{
            ScrollView{
                LazyVStack(spacing:12){
                    // SeatGeek identical Event IDs occur multiple times within response (same events)
                    // Workaround
                    ForEach(Array(zip(events.indices, events)), id:\.0){ _, event in
                        NavigationLink(destination: EventDetailsView(event: event, favIDs: $eventManager.favoriteIDs)) {
                            EventBriefView(event: event, favIDs: eventManager.favoriteIDs)
                                .padding(.horizontal, 10)
                                .onAppear{
                                    if event == events.last {
                                        eventManager.fetchNextPage()
                                    }
                                }
                        }
                    }
                }
            }
            // .searchable(text: $eventManager.query, placement: .navigationBarDrawer(displayMode: .always), prompt: nil)
            .searchable(text: $eventManager.query, placement: .navigationBarDrawer(displayMode: .automatic), prompt: nil)
            
            .navigationBarTitleDisplayMode(.inline)
            // .navigationTitle("")
            
        }.accentColor(.gray)
            .alert(item: $eventManager.error) { error in
                Alert(
                    title: Text("Network error"),
                    message: Text(error.errorDescription),
                    dismissButton: .cancel()
                )
            }
            .onReceive(eventManager.$allEvents) {
                self.events = $0
            }
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        //.previewInterfaceOrientation(.portrait)
    }
}
