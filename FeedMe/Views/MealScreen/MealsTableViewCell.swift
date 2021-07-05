//
//  MealsTableViewCell.swift
//  FeedMe
//
//  Created by Ayman Omara on 05/07/2021.
//

import UIKit

class MealsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var mealImage: UIImageView!
    
    @IBOutlet weak var mealLabel: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
