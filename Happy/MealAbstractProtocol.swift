//
//  MealAbstractProtocol.swift
//  Happy
//
//  Created by Ivan Trofimov on 14.03.17.
//  Copyright © 2017 Ivan Trofimov. All rights reserved.
//

import Foundation

protocol MealAbstractProtocol {
    var name: String {get}
    var description: String {get}
    var id: Int {get}
    var type: Int {get}
}
