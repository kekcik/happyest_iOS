//
//  MaelTVC.swift
//  Happy
//
//  Created by Ivan Trofimov on 21.03.17.
//  Copyright © 2017 Ivan Trofimov. All rights reserved.
//

import UIKit

class MeallTVC: UITableViewController {

    @IBOutlet var additionalView: UIView!
    @IBOutlet var mealTable: UITableView!
    @IBOutlet var blurView: UIVisualEffectView!
    
    func showAdditionalView () {
        self.view.addSubview(blurView)
        self.view.addSubview(additionalView)
        blurView.frame = CGRect(
            x: self.view.frame.minX,
            y: self.view.frame.minY - 64,
            width: self.view.frame.width,
            height: self.view.frame.height + 64)
        additionalView.layer.cornerRadius = 10
        additionalView.frame = CGRect(
            x: self.view.frame.midX - self.view.frame.width * 0.35,
            y: self.view.frame.midY - self.view.frame.height * 0.35 - 48,
            width: self.view.frame.width * 0.7,
            height: self.view.frame.height * 0.7)
        mealTable.isScrollEnabled = false
    }
    
    func hideAdditionalView () {
        self.view.willRemoveSubview(blurView)
        self.view.willRemoveSubview(additionalView)
        mealTable.isScrollEnabled = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(MenuManager.getAllMeals().count)
        return MenuManager.getAllMeals().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealCell") as! MealTBCell
        cell.title.text = MenuManager.getAllMeals()[indexPath.item].name
        cell.descript.text = MenuManager.getAllMeals()[indexPath.item].description
        cell.mass.text = "\(MenuManager.getAllMeals()[indexPath.item].height) г."
        cell.mainImage.image = UIImage(named: "img1.png")
        let im = ImageManager()
        cell.mainImage.image = im.getMessageBy(name: MenuManager.getAllMeals()[indexPath.item].image)
        print(MenuManager.getAllMeals()[indexPath.item].name)
        return cell
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
