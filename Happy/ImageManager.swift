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
    func getMessageBy(name: String) -> UIImage {
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
            return ImageManager.mealMap[pName]!;
        }
        
        let imgURL : NSURL? = NSURL(string: "https://happyest.ru/files/\(pName)?size=512")
        if (imgURL == nil || imgURL as? URL == nil) {
            #if DEBUG
                print("Error downloading \(name)")
            #endif
            return UIImage()
        }
        let imgData : NSData? = (NSData(contentsOf: imgURL as! URL))
        if (imgData == nil || imgData as? Data == nil || UIImage(data: imgData as! Data) == nil) {
            #if DEBUG
                print("Error downloading \(name)")
            #endif
            return UIImage()
        }
        let image = UIImage(data: imgData as! Data)!
        ImageManager.mealMap[pName] = image
        return image
    }
}
