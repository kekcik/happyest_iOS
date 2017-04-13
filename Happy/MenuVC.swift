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
        self.navigationItem.title = "Счастье есть!"
        let pm = ProductManager()
        pm.call()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.title = "Счастье есть!"
    }
    
        
    @IBAction func categoryButton(_ sender: UIButton) {
        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "MeallVC") as! MeallVC
        VC1.category = sender.tag
        self.navigationItem.title = "Меню"
        VC1.categoryTitle = CategoryManager.sh.getCategoryFor(type: sender.tag)
        self.navigationController?.pushViewController(VC1, animated: true)
    }
}

