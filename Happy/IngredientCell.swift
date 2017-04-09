//
//  IngredientCell
//  Happy
//
//  Created by Ivan Trofimov on 05.04.17.
//  Copyright © 2017 Ivan Trofimov. All rights reserved.
//

import UIKit

class IngredientCell: UITableViewCell {
    @IBOutlet weak var addButtonOutlet: UIButton!
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var title: UILabel!
    
    var select = false
    var id = -1

    @IBAction func addButtonAction(_ sender: UIButton) {
        print("press on \(id)")
        let vc = self.parentViewController! as! MeallVC
        vc.selectIngredientFor(id: id)
        select = !select
        checkSelection()
    }
    
    func checkSelection() {
        if !select {
            addButtonOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkboxUnselect"), for: .normal)
        } else {
            addButtonOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkboxSelect"), for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        checkSelection()
    }
    
}
