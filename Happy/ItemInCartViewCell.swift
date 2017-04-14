//
//  ItemInCartViewCell.swift
//  Happy
//
//  Created by Ivan Trofimov on 07.04.17.
//  Copyright © 2017 Ivan Trofimov. All rights reserved.
//

import UIKit

class ItemInCartViewCell: UITableViewCell {
    var id = UUID()
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descript: UILabel!
    @IBOutlet weak var priceForOne: UILabel!
    @IBOutlet weak var priceForAll: UILabel!
    @IBOutlet weak var stepperCount: UILabel!
    @IBOutlet weak var mainView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 8
        mainView.layer.borderWidth = 0.5
        mainView.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    @IBAction func stepperButton(_ sender: UIButton) {
        if sender.tag == 117 {
            CartManager.sh.decMealFor(id: id)
            print("dec")
        } else {
            CartManager.sh.incMealFor(id: id)
            print("inc")
        }
        let vc = self.parentViewController as! CartVC
        vc.updateCart()
    }
}
