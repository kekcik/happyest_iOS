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
    
    func getImageFromMap(meal: Meal) -> UIImage? {
        let name = parseName(str: meal.image)
        return ImageManager.mealMap[name]
    }
    
    private func parseName (str: String) -> String{
        var letters = str.characters.map { String($0) }
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
        return letters.joined()
    }
    
    func getImageWith(meal: Meal, cell: MealTBCell) {
        let name = meal.image
        if cell.title.text! != meal.name {
            return
        }
        let pName = parseName(str: name)
        if ImageManager.mealMap[pName] != nil {
            cell.backgroundImage.image = ImageManager.mealMap[pName]!
            cell.mainImage.image = ImageManager.mealMap[pName]!
            return
        }
        DispatchQueue.global(qos: .background).async {
            let imgURL : NSURL? = NSURL(string: "https://happyest.ru/files/\(pName)?size=256")
            if (imgURL == nil || imgURL as URL? == nil) {
                print("Error downloading \(name)")
                return
            }
            let imgData : NSData? = (NSData(contentsOf: imgURL! as URL))
            if (imgData == nil || imgData as Data? == nil || UIImage(data: imgData! as Data) == nil) {
                print("Error downloading \(name)")
                return
            }
            let image = UIImage(data: imgData! as Data)!
            ImageManager.mealMap[pName] = image
            DispatchQueue.main.async {
                if cell.title.text! != meal.name {
                    return
                }
                if ImageManager.mealMap[pName] == nil {
                    return self.getImageWith(meal: meal, cell: cell)
                }
                cell.backgroundImage.image = ImageManager.mealMap[pName]!
                cell.mainImage.image = ImageManager.mealMap[pName]!
            }
        }
    }
}
