//
//  Sushi.swift
//  Happy
//
//  Created by Ivan Trofimov on 14.03.17.
//  Copyright © 2017 Ivan Trofimov. All rights reserved.
//

import Foundation

class Sushi: Meal {
    var price: Int
    var height: Int
    init(name: String, description: String,
         id: Int, type: Int,
         image: String, available: Bool,
         price: Int, height: Int){
        self.price = price
        self.height = height
        super.init(
            name: name, description: description,
            id: id, type: type,
            image: image, available: available)
    }
}
