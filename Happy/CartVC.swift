//
//  CartVC.swift
//  Happy
//
//  Created by Ivan Trofimov on 18.03.17.
//  Copyright © 2017 Ivan Trofimov. All rights reserved.
//

import UIKit

class CartVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var cartTable: UITableView!
    @IBOutlet weak var orderOutlet: UIButton!
    @IBOutlet weak var promocodeOutlet: UIButton!
    
    var totalPrice = 0
    var localMeals = [(m: Meal, a: Int, id: UUID)]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateCart()
    }
    
    func updateCart() {
        localMeals = CartManager.sh.getCart()
        totalPrice = CartManager.sh.getPrice()
        orderOutlet.setTitle("Заказать за \(totalPrice) рублей", for: .normal)
        cartTable.reloadData()
    }
}


extension CartVC {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return localMeals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return preinstallItemInCartCellFor(tableView:tableView, indexPath:indexPath)
    }
    
    func preinstallItemInCartCellFor(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemInCart") as! ItemInCartViewCell
        let localMeal = localMeals[indexPath.item]
        cell.title.text = localMeal.m.name
        cell.descript.text = CategoryManager.sh.getCategoryFor(type: localMeal.m.type)
        let price = localMeal.m.price
        cell.priceForOne.text = String(price) + "₽"
        cell.priceForAll.text = String(price * localMeal.a) + "₽"
        cell.id = localMeal.id
        cell.selectionStyle = .none
        cell.stepperCount.text = String(localMeal.a)
        return cell
    }
    
}
