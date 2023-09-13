//
//  RealmManager.swift
//  PhinconTest
//
//  Created by reza pahlevi on 13/09/23.
//

import Foundation
import RealmSwift

class RealmManager: NSObject {
    
    static let shared = RealmManager()
    let realm = try! Realm()
    
    func createPokemonData(url: String, imageUrl: String, nickName: String, name: String) {
        do {
            try realm.write {
                let pokemon = MyPokemonList()
                pokemon.url = url
                pokemon.imageURL = imageUrl
                pokemon.nickName = nickName
                pokemon.nickNameUpdated = nickName
                pokemon.name = name
                realm.add(pokemon)
            }
        } catch {
            print("error creating history data: \(error)")
        }
    }
    
    func getMyPokemonList() -> [MyPokemonList] {
        var myPokemonList: [MyPokemonList] = []
        let data = realm.objects(MyPokemonList.self)
        myPokemonList.append(contentsOf: data)
        return myPokemonList
    }
    
    
    func delete(_ objects : Object) {
        try! realm.write {
            realm.delete(objects)
        }
    }
    
    func updateNickNamePokemon(_ pokemon: MyPokemonList) {
        do {
            try realm.write {
                let fibonacci = Helper.fibonacciSeries(num: pokemon.fibonacci)
                pokemon.nickNameUpdated = "\(pokemon.nickName)-\(fibonacci)"
                pokemon.fibonacci += 1
            }
        } catch {
            print("ERROR UPDATING CURRENT TOTAL DELIVERED ORDER: \(error)")
        }
    }
    
}
