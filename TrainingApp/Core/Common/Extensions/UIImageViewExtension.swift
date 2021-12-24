//
//  UIImageViewExstension.swift
//  TrainingApp
//
//  Created by Андрей Моисеев on 21.12.2021.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(imageUrl: String) {
        self.kf.setImage(with: URL(string: imageUrl))
    }
}
