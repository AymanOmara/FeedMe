//
//  MealsTableViewCell.swift
//  FeedMe
//
//  Created by Ayman Omara on 05/07/2021.
//

import UIKit

class MealsTableViewCell: UITableViewCell {
    override open func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 15
        layer.masksToBounds = false
    }
    override open var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 10
            frame.origin.x += 10
            frame.size.height -= 15
            frame.size.width -= 2 * 10
            super.frame = frame
        }
    }

    @IBOutlet weak var mealImage: UIImageView!
    
    @IBOutlet weak var mealLabel: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }


}
