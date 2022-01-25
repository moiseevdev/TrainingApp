//
//  CharityEventViewController.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 01.10.2021.
//

import UIKit

final class CharityEventViewController: UIViewController {
    
    var categoryId: Int?
    
    var viewModel: CharityEventViewModelProtocol!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let backButtonImage = Images.rectangle7
    private let filterButtonImage = Images.filter
    
    private let itemsPerRow: CGFloat = 1
    private let sectionInserts = UIEdgeInsets(top: 10, left: 8, bottom: 20, right: 8)
    
    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .medium
        activityIndicator.color = .black
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        viewModel.fetchEvents()
        setupNavigationBar()
        setupCollectionView()
        setupSegmentedcontrol()
        showActivityIndicator()
        reloadCollectionViewData()
    }
}

// MARK: - Private methods
private extension CharityEventViewController {
    
    func showActivityIndicator() {
        collectionView.isHidden = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor).isActive = true
    }
    
    func hideActivityIndicator() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        collectionView.isHidden = false
    }
    
    func reloadCollectionViewData() {
        viewModel?.reloadCollectionViewData = { [weak self] in
            self?.collectionView.reloadData()
            self?.hideActivityIndicator()
        }
    }
    
    func setupNavigationBar() {
        title = Strings.childrens
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(popViewController))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: filterButtonImage,
                                                            style: .plain,
                                                            target: nil,
                                                            action: nil)
    }
    
    func setupCollectionView() {
        collectionView.register(UINib(nibName: "CharityEventViewCell", bundle: nil), forCellWithReuseIdentifier: "CharityEventViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = CustomColors.lightGrey
    }
    
    func setupSegmentedcontrol() {
        segmentedControl.backgroundColor = UIColor.white
        segmentedControl.layer.borderColor = CustomColors.greenColor.cgColor
        segmentedControl.selectedSegmentTintColor = CustomColors.greenColor
        segmentedControl.layer.borderWidth = 1
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: CustomColors.greenColor]
        segmentedControl.setTitleTextAttributes(titleTextAttributes, for:.normal)
        
        let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentedControl.setTitleTextAttributes(titleTextAttributes1, for:.selected)
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "Failed to get data", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension CharityEventViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharityEventViewCell.identifier, for: indexPath) as? CharityEventViewCell {
            guard let viewModel = viewModel else {
                return UICollectionViewCell()
            }
            let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
            cell.viewModel = cellViewModel
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CharityEventViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 359, height: 413)
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
        let event = viewModel.events[indexPath.item]
        guard let eventId = event.eventId else {
            return
        }
        let eventDetailsViewController = SceneAssemblyService().buildEventDetailsModule()
        navigationController?.pushViewController(eventDetailsViewController, animated: true)
    }
    
}
