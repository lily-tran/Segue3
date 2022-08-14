//
//  NetworkError.swift
//  Segue3
//
//  Created by Lily Tran on 8/12/22.
//

import Foundation

enum NetworkError: LocalizedError {
    
case invalidURL
case thrownError(Error)
case noData
case unableToDecode
case badResponse
case invalidImageURL
case noImage
    
    /// Whatever info you think the user should know.
    var errorDescription: String? {
        switch self {
        case .thrownError(let error):
            return "Error in \(#function) : \(error.localizedDescription) \n---\n \(error)"
        case .invalidURL:
            return "Unable to reach the server."
        case .noData:
            return "The server responded with no data."
        case .unableToDecode:
            return "The server responded with bad data."
        case .badResponse:
            return "Bad response from API."
        case .invalidImageURL:
            return "Unable to reach image from link."
        case .noImage:
            return "The image does not exist."
        }
    }
}
