//
//  ImageManager.swift
//  Happy
//
//  Created by Ivan Trofimov on 16.03.17.
//  Copyright © 2017 Ivan Trofimov. All rights reserved.
//

import Foundation
import UIKit

class ImageManager {
    private static var mealMap : [String: UIImage] = [:]
    func getImageWith(meal: Meal, cell: MealTBCell) {
        let name = meal.image
        if cell.title.text! != meal.name {
            return
        }
        print("call for \(meal.name)")
        var letters = name.characters.map { String($0) }
        for i in 0...letters.count - 1 {
            if letters[i] == " " {
                letters[i] = "%20"
            }
        }
        while (letters.contains("?")) {
            if letters.last == "?" {
                letters.removeLast()
                continue
            }
            letters.removeLast()
        }
        
        let pName = letters.joined()
        
        if ImageManager.mealMap[pName] != nil {
            cell.mainImage.image = ImageManager.mealMap[pName]!
            
            print("from cache for \(meal.name)")
            return
        }
        DispatchQueue.global(qos: .background).async {
            let imgURL : NSURL? = NSURL(string: "https://happyest.ru/files/\(pName)?size=256")
            if (imgURL == nil || imgURL as URL? == nil) {
                #if DEBUG
                    print("Error downloading \(name)")
                #endif
                return
            }
            let imgData : NSData? = (NSData(contentsOf: imgURL! as URL))
            if (imgData == nil || imgData as Data? == nil || UIImage(data: imgData! as Data) == nil) {
                #if DEBUG
                    print("Error downloading \(name)")
                #endif
                return
            }
            let image = UIImage(data: imgData! as Data)!
            ImageManager.mealMap[pName] = image
            print("download for \(meal.name)")
            DispatchQueue.main.async {
                if cell.title.text! != meal.name {
                    return
                }
                cell.mainImage.image = ImageManager.mealMap[pName]!
            }
        }
    }
}
