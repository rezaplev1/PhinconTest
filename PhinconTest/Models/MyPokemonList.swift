//
//  MyPokemonList.swift
//  PhinconTest
//
//  Created by reza pahlevi on 13/09/23.
//

import Foundation
import RealmSwift

class MyPokemonList: Object {
    
    @objc dynamic var url: String = ""
    @objc dynamic var imageURL: String = ""
    @objc dynamic var nickName: String = ""
    @objc dynamic var nickNameUpdated: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var fibonacci: Int = 0
}
