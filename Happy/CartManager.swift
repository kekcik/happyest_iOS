//
//  CartManager.swift
//  Happy
//
//  Created by Ivan Trofimov on 18.03.17.
//  Copyright © 2017 Ivan Trofimov. All rights reserved.
//

import Foundation

class CartManager {
    static let sh = CartManager() // shared instance
    private init() {}
    private var cartInDic = Dictionary<UUID, (m: Meal, a: Int)>()
    private var cartInArr = [(m: Meal, a: Int, id: UUID)]()
    private var totalPrice = 0
    func putMeal(maels: Meal) {
        cartInDic[UUID()] = (m: maels, a: 1)
    }
    
    func getPrice() -> Int {
        totalPrice = 0
        for el in cartInDic {
            totalPrice += el.value.m.price * el.value.a
        }
        return totalPrice
    }
    
    func getCart() -> [(m: Meal, a: Int, id: UUID)] {
        cartInArr.removeAll()
        
        for el in cartInDic {
            cartInArr += [(m: el.value.m, a: el.value.a, el.key)]
        }
        
        cartInArr.sort { (a, b) -> Bool in
            if ((a.m as? Pizza) != nil) && ((b.m as? Pizza) != nil){
                print("pizza copies")
                return
                    ObjectIdentifier(a.m as! Pizza).hashValue <
                        ObjectIdentifier(b.m as! Pizza).hashValue
            }
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
    
    private func union(a: UUID, b: UUID) {
        cartInDic[a]!.a += cartInDic[b]!.a
        cartInDic.removeValue(forKey: b)
    }
    
    func incMealFor(id: UUID) {
        let meal = cartInDic[id]
        if meal != nil {
            cartInDic.updateValue((m: meal!.m, a: meal!.a + 1), forKey: id)
        }
    }
    
    func decMealFor(id: UUID) {
        let meal = cartInDic[id]
        if meal != nil {
            cartInDic.updateValue((m: meal!.m, a: meal!.a - 1), forKey: id)
            if meal!.a == 1 {
                cartInDic.removeValue(forKey: id)
            }
        }
    }
    
}
