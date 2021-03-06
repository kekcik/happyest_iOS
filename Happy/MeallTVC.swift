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
    @IBOutlet var closeButton: UIButton!
    
    @IBOutlet weak var ingredientTable: UITableView!
    @IBOutlet weak var mealImg: UIImageView!
    @IBOutlet weak var mealTtitle: UILabel!
    @IBOutlet weak var mealPrice: UILabel!
    
    var currentMeal: Meal?
    var localIngredients : [(Ingredient, Bool)] = []

    var effect : UIVisualEffect?
    var category: Int = 0
    var categoryTitle = ""
    var meals: [Meal] = []
    
    @IBAction func hideButton(_ sender: UIButton) {
        animateOut()
    }
    
    @IBAction func addInCart(_ sender: UIButton) {
        var copyIng : [Int] = []
        for ing in localIngredients {
            if ing.1 {
                copyIng += [ing.0.id]
            }
        }
        if currentMeal!.type == 0 {
            let pizza = currentMeal!.copy() as! Pizza
            pizza.additives = copyIng
            CartManager.sh.putMeal(maels: pizza)
        } else {
            let wok = currentMeal!.copy() as! Wok
            wok.additives = copyIng
            CartManager.sh.putMeal(maels: wok)
        }
        animateOut()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        getMeals()
    }
    
    func addIngredients(ing: [Int]) {
        print("update ingredietns")
        localIngredients = []
        let ingredients = MenuManager.sh.getAllIngredients()
        for ing in ingredients {
            localIngredients += [(ing, false)]
        }
    }
    
    func selectIngredientFor(id: Int) {
        print("call selectIngredientFor for \(id)")
        for i in 0 ... localIngredients.count - 1 {
            let ing = localIngredients[i]
            if ing.0.id == id {
                print("find for \(id)")
                localIngredients[i].1 = !localIngredients[i].1
                break
            }
        }
    }
}

/*
 * Custom Initialization
 */
extension MeallVC {
    func initUI () {
        self.navigationItem.title = categoryTitle
        effect = blurView.effect
        blurView.effect = nil
    }
    func getMeals () {
        meals = MenuManager.sh.getMealsFor(category: category)
    }
}

/*
 * TableView part of MeallVC
 */
extension MeallVC {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView.tag {
        case 111:
            return 180
        case 222:
            return 44
        default:
            return 44
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch tableView.tag {
        case 111:
            return meals.count
        case 222:
            switch currentMeal!.type {
            case 0:
                let pizza = currentMeal! as! Pizza
                return pizza.additives.count
            case 3:
                let wok = currentMeal! as! Wok
                return wok.additives.count
            default:
                return 0
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView.tag {
        case 111:
            return preinstallMealCellFor(tableView: tableView, indexPath: indexPath)
        case 222:
            return preinstallIngredientCellFor(tableView: tableView, indexPath:indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    func preinstallMealCellFor(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newPizzaCell") as! MealTBCell
        cell.title.text = meals[indexPath.item].name
        cell.descript.text = meals[indexPath.item].description
        //cell.mass.text = "\(meals[indexPath.item].height) г."
        cell.mainImage.image = UIImage(named: "img1.png")
        //cell.backgroundImage.image = UIImage(named: "img1.png")
        cell.selectionStyle = .none
        cell.meal = meals[indexPath.item]
        let im = ImageManager()
        im.getImageWith(meal: meals[indexPath.item], cell: cell)
        return cell
    }
    
    func preinstallIngredientCellFor(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell") as! IngredientCell
        cell.select = localIngredients[indexPath.item].1
        cell.title.text = localIngredients[indexPath.item].0.title
        cell.price.text = "\(localIngredients[indexPath.item].0.price)₽"
        cell.id = localIngredients[indexPath.item].0.id
        cell.checkSelection()
        cell.selectionStyle = .none
        return cell
    }
}

/*
 *  Animation and init for additionalView. Part of MeallVC
 */
extension MeallVC {
    func initAdditionalView() {
        let im = ImageManager()
        if currentMeal!.type == 0 {
            let pizza = currentMeal! as! Pizza
            addIngredients(ing: pizza.additives)
        } else {
            let wok = currentMeal! as! Wok
            addIngredients(ing: wok.additives)
        }
        mealImg.image = im.getImageFromMap(meal: currentMeal!)
        mealPrice.text = "\(currentMeal!.price)₽"
        //mealTtitle.text = currentMeal!.name
        ingredientTable.reloadData()
    }
    func animateIn() {
        self.view.addSubview(blurView)
        self.view.addSubview(additionalView)
        self.view.addSubview(closeButton)
        mealTable.isScrollEnabled = false
        blurView.frame = CGRect(
            x: self.view.frame.minX,
            y: self.view.frame.minY - 64,
            width: self.view.frame.width,
            height: self.view.frame.height)
        additionalView.clipsToBounds = true
        additionalView.layer.cornerRadius = 10
        additionalView.center = CGPoint(
            x: self.view.center.x,
            y: self.view.center.y - 64)
        additionalView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        additionalView.alpha = 0
        
        closeButton.alpha = 0
        closeButton.center = CGPoint(
            x: self.view.center.x,
            y: self.view.center.y + 180
        )
        closeButton.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)

        UIView.animate(withDuration: 0.4) {
            self.blurView.effect = self.effect
            self.additionalView.alpha = 1
            self.closeButton.alpha = 1
            self.additionalView.transform = CGAffineTransform.identity
            self.closeButton.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut() {
        mealTable.isScrollEnabled = true
        UIView.animate(withDuration: 0.3, animations: {
            self.additionalView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.closeButton.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.additionalView.alpha = 0
            self.closeButton.alpha = 0
            self.blurView.effect = nil
        }) { (Bool) in
            self.additionalView.removeFromSuperview()
            self.blurView.removeFromSuperview()
            self.closeButton.removeFromSuperview()
        }
    }
}
