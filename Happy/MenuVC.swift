//
//  ViewController.swift
//  Happy
//
//  Created by Ivan Trofimov on 09.03.17.
//  Copyright © 2017 Ivan Trofimov. All rights reserved.
//

import UIKit
import Spring

class MenuVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pm = ProductManager()
        pm.call()
    }
}

