//
//  TableViewCell.swift
//  Happy
//
//  Created by Ivan Trofimov on 21.03.17.
//  Copyright © 2017 Ivan Trofimov. All rights reserved.
//

import UIKit

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

class MealTBCell: UITableViewCell {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descript: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var mass: UILabel!
    
    @IBAction func stepper(_ sender: UIStepper) {
        let vc = self.parentViewController as? MeallTVC
        if ((vc) != nil) {
            vc!.showAdditionalView()
        } else {
            print("не ок")
        }
        amount.text = "\(Int(sender.value))"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
