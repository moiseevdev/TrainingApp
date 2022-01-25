//
//  CategoriesViewController.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 26.09.2021.
//

import UIKit

protocol CategoriesDisplayLogic: AnyObject {
    func displayData(viewModel: CategoriesModel.ViewModel.ViewModelData)
}

final class CategoriesViewController: UIViewController {
    
    var interactor: CategoriesBusinessLogic?
    var router: (NSObjectProtocol & CategoriesRoutingLogic)?
    
    private var categoriesViewModel: [CategoryModel]?

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
        interactor?.makeRequest(request: .getCategories)
    }
}

extension CategoriesViewController: CategoriesDisplayLogic {
    func displayData(viewModel: CategoriesModel.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayNetworkResponse(categories: let categoriesViewModel):
            self.categoriesViewModel = categoriesViewModel
            reloadData()
        case .displayDatabaseResponse(categories: let categoriesViewModel):
            self.categoriesViewModel = categoriesViewModel
            reloadData()
        }
    }
    
    func reloadData() {
        self.categoriesCollectionView.reloadData()
        self.hideActivityIndicator()
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "Failed to get data", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Private methods
private extension CategoriesViewController {
    
    func showActivityIndicator() {
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
        return categoriesViewModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.identifier, for: indexPath) as? CategoriesCell {
            guard let cellViewModel = categoriesViewModel?[indexPath.row] else { return cell }
            cell.set(viewModel: cellViewModel)
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
        
        navigationController?.pushViewController(SceneAssemblyService().buildCharityEventModule(), animated: true)
    }
}
