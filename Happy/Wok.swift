//
//  Wok.swift
//  Happy
//
//  Created by Ivan Trofimov on 14.03.17.
//  Copyright © 2017 Ivan Trofimov. All rights reserved.
//

import Foundation

class Wok: Meal {
    var additives: [Int]
    init(name: String, description: String, id: Int, type: Int, image: String, available: Bool, price: Int, height: Int,
         additives: [Int]) {
        self.additives = additives
        super.init(name: name, description: description, id: id, type: type, image: image, available: available, price: price, height: height)
    }
    override func copy(with zone: NSZone? = nil) -> Any {
        print("call woks copies")
        let copy = Wok(name: name, description: description, id: id, type: type, image: image, available: available, price: price, height: height, additives: additives)
        return copy
    }
}
