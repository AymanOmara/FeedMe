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
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

}
