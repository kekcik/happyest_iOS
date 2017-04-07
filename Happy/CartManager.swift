//
//  CartManager.swift
//  Happy
//
//  Created by Ivan Trofimov on 18.03.17.
//  Copyright © 2017 Ivan Trofimov. All rights reserved.
//

import Foundation

class CartManager {
    private static var cartInDic = Dictionary<UUID, (m: Meal, a: Int)>()
    private static var cartInArr = [(m: Meal, a: Int, id: UUID)]()
    private static var totalPrice = 0
    static func putMeal(maels: Meal) {
        cartInDic[UUID()] = (m: maels, a: 1)
    }
    
    static func getPrice() -> Int {
        totalPrice = 0
        for el in cartInDic {
            totalPrice += el.value.m.price * el.value.a
        }
        return totalPrice
    }
    
    static func getCart() -> [(m: Meal, a: Int, id: UUID)] {
        cartInArr.removeAll()
        for el in cartInDic {
            cartInArr += [(m: el.value.m, a: el.value.a, el.key)]
        }
        cartInArr.sort { (a, b) -> Bool in
            return ObjectIdentifier(a.m).hashValue < ObjectIdentifier(b.m).hashValue
        }
        if cartInArr.count > 1 {
            var needToUpdate = false
            for i in 0 ... (cartInArr.count - 2) {
                let a = ObjectIdentifier(cartInArr[i + 1].m)
                let b = ObjectIdentifier(cartInArr[i].m)
                if a.hashValue == b.hashValue {
                    cartInArr[i + 1].a += cartInArr[i].a
                    union(a: cartInArr[i + 1].id, b: cartInArr[i].id)
                    needToUpdate = true
                }
            }
            if needToUpdate {
                return getCart()
            }
        }
        
        return cartInArr
        
    }
    
    private static func union(a: UUID, b: UUID) {
        cartInDic[a]!.a += cartInDic[b]!.a
        cartInDic.removeValue(forKey: b)
    }
    
    static func incMealFor(id: UUID) {
        let meal = cartInDic[id]
        if meal != nil {
            cartInDic.updateValue((m: meal!.m, a: meal!.a + 1), forKey: id)
        }
    }
    
    static func decMealFor(id: UUID) {
        let meal = cartInDic[id]
        if meal != nil {
            cartInDic.updateValue((m: meal!.m, a: meal!.a - 1), forKey: id)
            if meal!.a == 1 {
                cartInDic.removeValue(forKey: id)
            }
        }
    }
    
}
