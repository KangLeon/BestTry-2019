//
//  FavoritesList.swift
//  Font
//
//  Created by 吉腾蛟 on 2019/9/16.
//  Copyright © 2019 JY. All rights reserved.
//

import Foundation
import UIKit

class FavoritesList {
    class var sharedFavoriteList: FavoritesList {
        struct Singleton {
            static let instance = FavoritesList()
        }
        return Singleton.instance
    }
    
    private(set) var favorites: [String]
    
    init() {
        let defaults = UserDefaults.standard
        let storedFavorites = defaults.object(forKey: "favorite") as? [String]
        favorites = storedFavorites != nil ? storedFavorites! : []
    }
    
    func addFavorite(fontName: String) {
        if !favorites.contains(fontName) {
            favorites.append(fontName)
            saveFavorites()
        }
    }
    
    func removeFavorite(fontName: String) {
        if let index = favorites.firstIndex(of: fontName) {
            favorites.remove(at: index)
            saveFavorites()
        }
    }
    
    private func saveFavorites() {
        let defaults = UserDefaults.standard
        defaults.set(favorites, forKey: "favorite")
        defaults.synchronize()
    }
}
