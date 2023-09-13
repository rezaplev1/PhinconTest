//
//  PokemonDetailViewModel.swift
//  PhinconTest
//
//  Created by reza pahlevi on 13/09/23.
//

import Foundation

protocol PokemonDetailViewModelDelegate: AnyObject {
    func success()
    func failedReq(message: String)
    
}

class PokemonDetailViewModel: BaseViewModel {
    
    weak var delegate: PokemonDetailViewModelDelegate?
    
    var pokemon: Pokemon?
    var pokemonDetail: PokemonDetail?
    
    
    func getPokemonDetail() {
        api.getRequest(ServiceConfig.getPokemonDetail(name: pokemon?.name ?? ""))
    }
    
    override init() {
        super.init()
    }
    
    override func finish(interFace: CoreApi, responseHeaders: HTTPURLResponse, data: Data) {
        do {
            switch interFace.serviceConfig {
            case .getPokemonDetail:
                let response = try JSONDecoder().decode(PokemonDetail.self, from: data)
                print(response)
                pokemonDetail = response
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
