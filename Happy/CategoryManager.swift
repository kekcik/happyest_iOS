//
//  CategoryManager.swift
//  Happy
//
//  Created by Ivan Trofimov on 07.04.17.
//  Copyright © 2017 Ivan Trofimov. All rights reserved.
//

import Foundation

class CategoryManager {
    static let sh = CategoryManager()
    private init() {}
    func getCategoryFor(type: Int) -> String {
        switch type {
        case 0:
            return "Пицца"
        case 1:
            return "Суши"
        case 2:
            return "Бургеры"
        case 3:
            return "Вок"
        case 4:
            return "Роллы"
        case 5:
            return "Сет"
        case 6:
            return "Напитки"
        case 7:
            return "Соусы"
        case 8:
            return "Закуски"
        default:
            return "Не понятно"
        }
        
    }
}
