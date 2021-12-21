//
//  API.swift
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

import Foundation
import Combine



struct API {
    
    struct EventRequest: Equatable {
        var page: Int
        var query: String? = nil
        var endPoint: EndPoint = API.EndPoint.events
        
        init() {
            self.page = 0
        }
        init(page: Int, query: String?, endPoint: API.EndPoint) {
            self.page = page
            self.query = query
            self.endPoint = endPoint
        }
    }
    
    enum Error: LocalizedError, Identifiable {
        var id: String { localizedDescription }
        
        case addressUnreachable(URL)
        case invalidResponse
        case invalidApiKey
        
        
        var errorDescription: String {
            switch self {
            case .invalidResponse: return "The server responded with error."
            case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
            case .invalidApiKey: return "API_KEY not found or empty"
            }
        }
    }
    
    
    private let maxEventsPerPage = 25
    private let decoder = JSONDecoder()
    
    init() {
        //FORMAT DATE
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
    }
    
    enum EndPoint {
        static let baseURL = URL(string: "https://api.seatgeek.com/2/")!
        
        case events
        
        var url: URL {
            switch self {
            case .events:
                return EndPoint.baseURL.appendingPathComponent("events")
            }
        }
    }
    
    
    public func makeRequest<T: Codable>(request: EventRequest, type: T.Type, requiresAuth: Bool? = false) -> AnyPublisher<T, Error> {
        var url = request.endPoint.url
        if let needsAuth = requiresAuth, needsAuth == true  {
            guard let urlA = request.endPoint.url.authorize() else {
                return Fail(error: Error.invalidApiKey).eraseToAnyPublisher()
            }
            url = urlA
        }
        let qItem1 = (name:"page",value:String(describing:request.page))
        let qItem2 = (name:"per_page",value:String(describing:maxEventsPerPage))
        var qItems = [qItem1, qItem2]
        if let q = request.query, !q.isEmpty {
            qItems.append((name:"q", value:q))
        }
        return URLSession.shared
            .dataTaskPublisher(for: url.appendingQueryItems(qItems))
            .map(\.data)
            .decode(type: type.self, decoder: decoder)
            .mapError{error -> API.Error in
                switch error {
                case is URLError:
                    return Error.addressUnreachable(request.endPoint.url)
                default:
                    return Error.invalidResponse
                }
            }
            .eraseToAnyPublisher()
    }
    
    
    
}

extension URL {
    fileprivate func authorize() -> URL? {
        guard let API_KEY = Bundle.main.infoDictionary?["API_KEY"] as? String, !API_KEY.isEmpty else {
            return nil
        }
        if self.absoluteString.contains("client_id") {
            return self
        }
        return self.appendingQueryItems([(name:"client_id", value: API_KEY)])
    }
}

extension URL {
    fileprivate func appendingQueryItems(_ items:[(name: String, value: String)]) -> URL {
        if items.isEmpty {
            return self
        }
        var urlQueryItems = items.map{URLQueryItem(name: $0.name, value: $0.value)}
        var urlComps = URLComponents(string: self.absoluteString)!
        if let queryItems = urlComps.queryItems {
            urlQueryItems.append(contentsOf: queryItems)
        }
        urlComps.queryItems = urlQueryItems
        return urlComps.url!
    }
}
