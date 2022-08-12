//
//  YelpFusionController.swift
//  Segue3
//
//  Created by Lily Tran on 8/12/22.
//
import SwiftUI

class YelpFusionController {
    static let baseURL = URL(string: "https://api.yelp.com")
    static let searchPathComponent = "v3/businesses/search"
    //static let searchPathComponent = "v3/events/featured"
    static let secret = "jABGafzLHVz70MOhwClTs75ZlsgLBzNaw9cXT_13qxJiCT0ZtoLq1mssxALmf80KjCwOiIIRzQFv75Qc14nf63j6g44d2o7Az00Y03KGN7Rwn8APyVNmKUXIuN7iYnYx"
    
    static func fetchYelpRequsts(location: String, completion: @escaping (Result<[Business], NetworkError>) -> Void) {
        let headers = [
            "Authorization": "Bearer \(secret)",
            "Content-Type": "application/json"
        ]
        let queryItems = [URLQueryItem(name: "location", value: location)]
        
        guard let baseURL = baseURL else {
            print("Step 1")
            return completion(.failure(.invalidURL))
        }
        let url = baseURL.appendingPathComponent(searchPathComponent)
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        components?.queryItems = queryItems
        
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL)) }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else {
                return completion(.failure(.noData))
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                print("DID I MAKE THIS FARE")
                let businesses = try JSONDecoder().decode(Businesses.self, from: data)
                print("DID I MAKE THIS FARE")
                
                print("These are the event(s)")
                //print(businesses.businesses)
                return completion(.success(businesses.businesses))
            } catch {
                return completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    static func fetchImage(with url: URL, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("There was an error")
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            print(data)
            
            guard let image = UIImage(data: data) else { return completion(.failure(.noImage)) }
            
            completion(.success(image))
        }.resume()
    }
}
