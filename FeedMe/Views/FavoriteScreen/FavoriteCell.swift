//
//  FavoriteCell.swift
//  FeedMe
//
//  Created by Ayman Omara on 20/07/2021.
//

import UIKit

class FavoriteCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

}
