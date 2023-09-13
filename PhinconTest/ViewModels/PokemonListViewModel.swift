//
//  PokemonListViewModel.swift
//  PhinconTest
//
//  Created by reza pahlevi on 13/09/23.
//

import Foundation

protocol PokemonListViewModelDelegate: AnyObject {
    func success()
    func failedReq(message: String)
    func hideTableviewFooter(isHidden: Bool)
}

class PokemonListViewModel: BaseViewModel {
    
    weak var delegate: PokemonListViewModelDelegate?
    
    var pokemonList: [Pokemon]?
    
    var onGoing : Bool = true
    var urlNext: String = ""
    
    func getPokemonList() {
        onGoing = true
        api.getRequest(ServiceConfig.getPokemonList(urlNext: urlNext))
    }
    
    override init() {
        super.init()
    }
    
    override func finish(interFace: CoreApi, responseHeaders: HTTPURLResponse, data: Data) {
        do {
            switch interFace.serviceConfig {
            case .getPokemonList:
                let response = try JSONDecoder().decode(PokemonList.self, from: data)
                if let next = response.next {
                    urlNext = next
                }else {
                    delegate?.hideTableviewFooter(isHidden: true)
                }
                
                if let result = response.results {
                    pokemonList = (pokemonList == nil) ? result : pokemonList! + result
                }
                onGoing = false
                delegate?.success()
            default:
                break
            }
        } catch _ {
            delegate?.failedReq(message: "Error mapping data")
        }
    }
    
    override func failed(interFace: CoreApi, result: AnyObject) {
        if let response = result as? String {
            delegate?.failedReq(message: response)
        }else{
            delegate?.failedReq(message: "something went wrong")
        }
    }
}
