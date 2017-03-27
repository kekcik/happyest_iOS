//
//  Meal.swift
//  Happy
//
//  Created by Ivan Trofimov on 14.03.17.
//  Copyright © 2017 Ivan Trofimov. All rights reserved.
//

import Foundation

class Meal {
    var name: String
    var description: String
    var id: Int
    var type: Int
    var image: String
    var available: Bool
    var price: Int
    var height: Int
    init(name: String, description: String,
         id: Int, type: Int,
         image: String, available: Bool,
         price: Int, height: Int) {
        self.available = available
        self.name = name
        self.description = description
        self.id = id
        self.type = type
        self.image = image
        self.price = price
        self.height = height
    }
}
