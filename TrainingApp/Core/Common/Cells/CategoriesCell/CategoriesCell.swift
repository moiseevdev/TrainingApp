
//
//  CategoriesCell.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 26.09.2021.
//

import UIKit

protocol CategoriesCellViewModel {
    var nameLabel: String { get }
    var categoryImage: String { get }
}

final class CategoriesCell: UICollectionViewCell {

    static let identifier = "CategoriesCell"
    
    @IBOutlet weak var categoryImage: UIImageView! 
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.font = CustomFonts.OfficinasansextraboldsccFont15
        nameLabel.textColor = CustomColors.lightOliveGreen
        backgroundColor = CustomColors.lightGrey2
    }
    
    func set(viewModel: CategoryModel) {
        nameLabel.text = viewModel.categoryName
        categoryImage.setImage(imageUrl: viewModel.image ?? "")
    }
}
