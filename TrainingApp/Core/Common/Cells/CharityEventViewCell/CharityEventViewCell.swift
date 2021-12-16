//
//  CharityEventViewCell.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 01.10.2021.
//

import UIKit

final class CharityEventViewCell: UICollectionViewCell {

    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var descriptionEventLabel: UILabel!
    @IBOutlet weak var timeLeftLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleNameLabel.font = CustomFonts.OfficinasansextraboldsccFont21
        titleNameLabel.textColor = CustomColors.blueGrey
    }
}
