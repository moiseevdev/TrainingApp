//
//  CategoriesViewController.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 26.09.2021.
//

import UIKit

struct ModelTest {
    let categoryID: Int
    let categoryName: String
    let image: String
}

final class CategoriesViewController: UIViewController {
    
    private var networkService = NetworkService()
    private var dataBase = DataBaseAdapter.dataBase

    var categories: [CategoryModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.categoriesCollectionView.reloadData()
                self.hideActivityIndicator()
            }
        }
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!

    private let itemsPerRow: CGFloat = 2
    private let sectionInserts = UIEdgeInsets(top: 7, left: 9, bottom: 20, right: 9)

    private let backButtonImage = Images.rectangle7
    
    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .medium
        activityIndicator.color = .black
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigitionBar()
        setupCollectionView()
        showActivityIndicator()
        
        networkService.fethCategories { result in
            switch result {
            case .success(let networkResponse):
                self.categories = networkResponse.map({ CategoryModel(categoryID: Int($0.categoryID),
                                                                      categoryName: $0.categoryName,
                                                                      image: $0.image) })
            case .failure:
                self.dataBase.getCategories { result in
                    switch result {
                    case .success(let coredataResponse):
                        self.categories = coredataResponse
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }

    }
    
    private func showActivityIndicator() {
        categoriesCollectionView.isHidden = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: categoriesCollectionView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: categoriesCollectionView.centerYAnchor).isActive = true
    }
    
    func hideActivityIndicator() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        categoriesCollectionView.isHidden = false
    }
    
    func setupNavigitionBar() {
        navigationItem.title = Strings.helpNavBar
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage,
                                                           style: .plain,
                                                           target: nil,
                                                           action: nil)
    }
    
    func setupCollectionView() {
        categoriesCollectionView.register(UINib(nibName: "CategoriesCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCell")
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
    }
    
}

// MARK: - UICollectionViewDataSource
extension CategoriesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as? CategoriesCell {
            let categories = categories[indexPath.item]
            cell.nameLabel.text = categories.categoryName
            cell.categoryImage.setImage(imageUrl: categories.image ?? "test")
            cell.backgroundColor = CustomColors.lightGrey2
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CategoriesViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let categories = categories[indexPath.item]
        guard let categoryID = categories.categoryID else { return }
        let categoryVC = CharityEventViewController()
        categoryVC.categoryId = categoryID
        navigationController?.pushViewController(categoryVC, animated: true)
    }
}
