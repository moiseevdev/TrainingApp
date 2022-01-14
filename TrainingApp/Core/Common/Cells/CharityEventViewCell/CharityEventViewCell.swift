//
//  CharityEventViewCell.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 01.10.2021.
//

import UIKit

protocol CharityEventCellViewModelType: AnyObject {
    var titleNameLabel: String { get }
    var titleImage: String { get }
    var descriptionEventLabel: String { get }
    var timeLeftLabel: String { get }
}

final class CharityEventViewCell: UICollectionViewCell {
    
    static let identifier = "CharityEventViewCell"

    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var descriptionEventLabel: UILabel!
    @IBOutlet weak var timeLeftLabel: UILabel!
    
    weak var viewModel: CharityEventCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            titleNameLabel.text = viewModel.titleNameLabel
            titleImage.setImage(imageUrl: viewModel.titleImage)
            descriptionEventLabel.text = viewModel.descriptionEventLabel
            timeLeftLabel.text = viewModel.timeLeftLabel
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleNameLabel.font = CustomFonts.OfficinasansextraboldsccFont21
        titleNameLabel.textColor = CustomColors.blueGrey
        backgroundColor = .white
    }
}
