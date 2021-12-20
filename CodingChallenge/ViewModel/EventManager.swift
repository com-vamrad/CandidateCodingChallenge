//
//  EventManager.swift
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
import Combine

class EventManager: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()
    private var meta: Meta?
//    {
//        didSet {
//            print("Meta page:\(String(describing: meta?.page)), can:\(meta?.canLoad), total:\(meta?.total), pages:\(meta?.totalPages)")
//        }
//    }
    private let api = API()
    private var lastFetchedPage = 0
    @Published var allEvents: [Event] = []
    @Published var error: API.Error? = nil
    @Published var query: String = ""
    
    
    //Store a Set of IDs of favorite events
    @AppStorage("favoriteIDs") var favoriteIDs = Set<Int>()
    
    
    init() {
        $query
        //Removing unnecessary requests
            .map{$0.trimmingCharacters(in: .whitespacesAndNewlines)}
            .removeDuplicates()
        //Wait while user types to reduce Network load
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink{query in
                //Every new search query starts from page 1
                self.fetchEvents(req: API.EventRequest(page: 1, query: self.query))
            }.store(in: &subscriptions)
        
    }
    
    
    
    func fetchNextPage() {
        //Fetch only if there are pages left on the server
        if meta?.canLoad ?? true {
            let pageToFetch = meta?.nextPage ?? 1
            if pageToFetch == lastFetchedPage {return}
            let req = API.EventRequest(page: pageToFetch, query: query)
            fetchEvents(req: req)
        }
    }
    
    
    
    private func fetchEvents(req: API.EventRequest) {
        lastFetchedPage = req.page
        api
            .events(req: req)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.error = error
                }
            },
                  receiveValue: { [unowned self] bulkResponse in
                print("Received page: \(req.page), q = \(String(describing: req.query))")
                if req.page > 1 {
                    self.allEvents += bulkResponse.events
                } else {
                    self.allEvents = bulkResponse.events
                }
                self.meta = bulkResponse.meta
                self.error = nil
            }
            )
            .store(in: &subscriptions)
    }
}

//To store set in UserDefaults we need to make it to conform RawRepresentable
extension Set: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode(Set<Element>.self, from: data)
        else {
            return nil
        }
        self = result
    }
    
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}



