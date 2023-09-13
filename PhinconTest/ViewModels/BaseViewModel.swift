//
//  BaseViewModel.swift
//  PhinconTest
//
//  Created by reza pahlevi on 13/09/23.
//

import Foundation

class BaseViewModel {
    
    let api = CoreApi()
    
    init() {
        api.delegate = self
    }
}

extension BaseViewModel: CoreApiDelegate {
    func finish(interFace: CoreApi, responseHeaders: HTTPURLResponse, data: Data) {
    }
    
    func failed(interFace: CoreApi, result: AnyObject) {
    }
}
