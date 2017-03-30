//
//  MaelTVC.swift
//  Happy
//
//  Created by Ivan Trofimov on 21.03.17.
//  Copyright © 2017 Ivan Trofimov. All rights reserved.
//

import UIKit

class MeallVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var additionalView: UIView!
    @IBOutlet var mealTable: UITableView!
    @IBOutlet var blurView: UIVisualEffectView!
    var effect : UIVisualEffect?
    
    @IBAction func hideButton(_ sender: UIButton) {
        animateOut()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Счастье есть!"
        effect = blurView.effect
        blurView.effect = nil
    }
}



/*
 * TableView part of MeallVC
 */
extension MeallVC {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(MenuManager.getAllMeals().count)
        return MenuManager.getAllMeals().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealCell") as! MealTBCell
        cell.title.text = MenuManager.getAllMeals()[indexPath.item].name
        cell.descript.text = MenuManager.getAllMeals()[indexPath.item].description
        cell.mass.text = "\(MenuManager.getAllMeals()[indexPath.item].height) г."
        cell.mainImage.image = UIImage(named: "img1.png")
        cell.selectionStyle = .none
        let im = ImageManager()
        im.getImageWith(meal: MenuManager.getAllMeals()[indexPath.item], cell: cell)
        print(MenuManager.getAllMeals()[indexPath.item].name)
        return cell
    }
}

/*
 *  Animation for additionalView
 */
extension MeallVC {
    
    
    func animateIn() {
        self.view.addSubview(blurView)
        self.view.addSubview(additionalView)
        additionalView.layer.cornerRadius = 10
        mealTable.isScrollEnabled = false
        blurView.frame = CGRect(
            x: self.view.frame.minX,
            y: self.view.frame.minY - 64,
            width: self.view.frame.width,
            height: self.view.frame.height)
        
        additionalView.center = CGPoint(
            x: self.view.center.x,
            y: self.view.center.y - 64)
        
        additionalView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        additionalView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.blurView.effect = self.effect
            self.additionalView.alpha = 1
            self.additionalView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut() {
        mealTable.isScrollEnabled = true
        UIView.animate(withDuration: 0.3, animations: {
            self.additionalView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.additionalView.alpha = 0
            self.blurView.effect = nil
            
        }) { (Bool) in
            self.additionalView.removeFromSuperview()
            self.blurView.removeFromSuperview()
        }
    }
}


