//
//  CartManager.swift
//  Happy
//
//  Created by Ivan Trofimov on 18.03.17.
//  Copyright © 2017 Ivan Trofimov. All rights reserved.
//

import Foundation

class CartManager {
    static var cart = [Meal]()
    static func putMeal(mael: Meal) {
        cart.append(mael)
    }
}
