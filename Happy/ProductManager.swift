//
//  ProductManager.swift
//  Happy
//
//  Created by Ivan Trofimov on 13.03.17.
//  Copyright © 2017 Ivan Trofimov. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import Spring

class ProductManager {
    public static var itemsAmount = 0
    

    func call () {
        print("Menu download start")
        Alamofire.request("http://happyest.ru/getdata?type=0").responseJSON { response in
            if let JSON1 = response.result.value {
                let json = JSON(JSON1)
                for meal in json["a"] {
                    ProductManager.itemsAmount += 1
                    do {
                        switch (meal.1["k"]){
                        case 0:
                            var adds = [Int]()
                            var opts = [PizzaOption]()
                            for add in meal.1["l"] {
                                adds.append(try JSONTo.int(json: add.1))
                            }
                            for opt in meal.1["n"] {
                                opts.append(PizzaOption.init(
                                    size: try JSONTo.int(json: opt.1["e"]),
                                    height: try JSONTo.int(json: opt.1["f"]),
                                    price: try JSONTo.int(json: opt.1["h"])))
                            }
                            let meal = Pizza.init(
                                name: try JSONTo.string(json: meal.1["o"]),
                                description: try JSONTo.string(json: meal.1["p"]),
                                id: try JSONTo.int(json: meal.1["j"]),
                                type: try JSONTo.int(json: meal.1["k"]),
                                image: try JSONTo.string(json: meal.1["q"]),
                                available: try JSONTo.bool(json: meal.1["E"]),
                                additives: adds,
                                options: opts)
                            MenuManager.putMeal(meal: meal)
                            break
                        case 3:
                            var adds = [Int]()
                            for add in meal.1["l"] {
                                adds.append(try JSONTo.int(json: add.1))
                            }
                            let meal = Wok.init(
                                name: try JSONTo.string(json: meal.1["o"]),
                                description: try JSONTo.string(json: meal.1["p"]),
                                id: try JSONTo.int(json: meal.1["j"]),
                                type: try JSONTo.int(json: meal.1["k"]),
                                image: try JSONTo.string(json: meal.1["q"]),
                                available: try JSONTo.bool(json: meal.1["E"]),
                                price: try JSONTo.int(json: meal.1["f"]),
                                height: try JSONTo.int(json: meal.1["h"]),
                                additives: adds)
                            MenuManager.putMeal(meal: meal)
                            
                            break
                        default:
                            let meal = Meal.init(
                                name: try JSONTo.string(json: meal.1["o"]),
                                description: try JSONTo.string(json: meal.1["p"]),
                                id: try JSONTo.int(json: meal.1["j"]),
                                type: try JSONTo.int(json: meal.1["k"]),
                                image: try JSONTo.string(json: meal.1["q"]),
                                available: try JSONTo.bool(json: meal.1["E"]),
                                price: try JSONTo.int(json: meal.1["f"]),
                                height: try JSONTo.int(json: meal.1["h"]))
                            MenuManager.putMeal(meal: meal)
                            break;
                        }
                    } catch {
                        print("ERROR: in serialization JSON")
                    }
                }
            }
        }
        print("Finished. Total == \(ProductManager.itemsAmount)")

    }
}
