//
//  Ingredient.swift
//  Happy
//
//  Created by Ivan Trofimov on 08.04.17.
//  Copyright © 2017 Ivan Trofimov. All rights reserved.
//

import Foundation

class Ingredient {
    var id: Int
    var price: Int
    var title: String
    init (id: Int, price: Int, title: String) {
        self.id = id
        self.price = price
        self.title = title
    }
}
