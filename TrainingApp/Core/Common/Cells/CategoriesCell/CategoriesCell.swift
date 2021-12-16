
//
//  CategoriesCell.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 26.09.2021.
//

import UIKit

final class CategoriesCell: UICollectionViewCell {

    @IBOutlet weak var categoryImage: UIImageView! 
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.font = CustomFonts.OfficinasansextraboldsccFont15
        nameLabel.textColor = CustomColors.lightOliveGreen
    }
}
