//
//  TableViewCell.swift
//  Happy
//
//  Created by Ivan Trofimov on 21.03.17.
//  Copyright © 2017 Ivan Trofimov. All rights reserved.
//

import UIKit

/*
 *  It's a problem, man
 */
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
    var meal: Meal?
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descript: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var mass: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    @IBAction func addButton(_ sender: UIButton) {
        if meal!.type == 3 || meal!.type == 0 {
            let vc = self.parentViewController as? MeallVC
            if ((vc) != nil) {
                vc!.currentMeal = meal
                vc!.initAdditionalView()
                vc!.animateIn()
            } else {
                print("problems with searcing parent VC")
            }
        } else {
            CartManager.sh.putMeal(maels: meal!)
        }
    }
    
    @IBAction func stepper(_ sender: UIStepper) {
        if meal!.type == 3 || meal!.type == 0 {
            let vc = self.parentViewController as? MeallVC
            if ((vc) != nil) {
                vc!.currentMeal = meal
                vc!.initAdditionalView()
                vc!.animateIn()
            } else {
                print("problems with searcing parent VC")
            }
        } else {
            CartManager.sh.putMeal(maels: meal!)
        }
        amount.text = "\(Int(sender.value))"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 8
        backView.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
