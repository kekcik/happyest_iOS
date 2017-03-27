//
//  PizzaModel.swift
//  Happy
//
//  Created by Ivan Trofimov on 14.03.17.
//  Copyright © 2017 Ivan Trofimov. All rights reserved.
//

import Foundation

class Pizza: Meal {
    var options: [PizzaOption]
    var additives: [Int]
    init(name:String, description: String,
         id: Int, type: Int,
         image: String, available: Bool,
         additives: [Int], options: [PizzaOption]) {
        self.options = options
        self.additives = additives
        super.init(
            name: name, description: description,
            id: id, type: type,
            image: image, available: available,
            price: options.count == 0 ? 0 : options[0].price,
            height: options.count == 0 ? 0 : options[0].height)
    }
}
