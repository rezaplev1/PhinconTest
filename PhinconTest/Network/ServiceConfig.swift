//
//  ServiceConfig.swift
//  PhinconTest
//
//  Created by reza pahlevi on 13/09/23.
//

import Foundation
import Alamofire

private let SERVICE_POKEMON = "pokemon"

enum ServiceConfig {
    case getPokemonList(urlNext: String)
    case getPokemonDetail(name: String)
}

extension ServiceConfig: URLRequestConvertible {
    var baseURL: String {
        switch self {
        case .getPokemonList, .getPokemonDetail:
            return Constants.BASE_URL
        }
    }
    
    var path: String {
        switch self {
        case .getPokemonList, .getPokemonDetail:
            return SERVICE_POKEMON
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPokemonList, .getPokemonDetail:
            return .get
  
        }
    }
    
    func createURLEncoding(url: URL, param: [String: Any] = [:]) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        
        do {
            urlRequest.httpMethod = method.rawValue
            urlRequest.timeoutInterval = TimeInterval(30)
            urlRequest = try URLEncoding.default.encode(urlRequest, with: param)
        } catch {
            print("ERROR ENCODE URL REQUEST")
        }
        
        return urlRequest
    }
    
    func createJSONEncoding(url: URL, param: [String: Any]) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        
        do {
            urlRequest.httpMethod = method.rawValue
            urlRequest.timeoutInterval = TimeInterval(30)
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: param)
        } catch {
            print("ERROR ENCODE URL REQUEST")
        }
        
        return urlRequest
    }
    
    public func asURLRequest() throws -> URLRequest {
        switch self {
        
        case .getPokemonList(let urlNext):
            var link = "\(baseURL)\(path)"
            if !urlNext.isEmpty {
                link = urlNext
            }
            let url = URL(string: link)!
            let urlRequest = createURLEncoding(url: url)
            return urlRequest
            
        case .getPokemonDetail(let name):
            let link = "\(baseURL)\(path)/\(name)"
            let url = URL(string: link)!
            let urlRequest = createURLEncoding(url: url)
            return urlRequest
        }
    }
}
