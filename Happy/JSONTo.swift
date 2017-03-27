//
//  JSONTo.swift
//  Happy
//
//  Created by Ivan Trofimov on 15.03.17.
//  Copyright © 2017 Ivan Trofimov. All rights reserved.
//

import Foundation
import SwiftyJSON

class JSONTo {
    enum SerializationError: Error {
        case toInt
        case toString
    }
    
    static func int(json: JSON) throws -> Int {
        if json.int != nil {
            return json.intValue
        } else if json.string != nil && Int(json.stringValue) != nil {
            return Int(json.stringValue)!
        } else {
            throw SerializationError.toInt
        }
    }
    
    static func string(json: JSON) throws -> String {
        if json.string == nil {
            throw SerializationError.toString
        } else {
            return json.stringValue
        }
    }
    
    static func bool(json: JSON) throws -> Bool {
        if json.bool == nil {
            throw SerializationError.toString
        } else {
            return json.boolValue
        }
    }
}
