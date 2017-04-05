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
    var select = false
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        if select {
            addButtonOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkboxUnselect"), for: .normal)
        } else {
            addButtonOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkboxSelect"), for: .normal)
        }
        select = !select
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addButtonOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkboxUnselect"), for: .normal)
    }

}
