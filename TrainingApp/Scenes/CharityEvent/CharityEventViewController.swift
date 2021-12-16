//
//  CharityEventViewController.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 01.10.2021.
//

import UIKit

class CharityEventViewController: UIViewController {

    private var dataBase = DataBaseAdapter.dataBase
    
    var categoryId: Int!

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let backButton = Images.rectangle7
    private let filterButton = Images.filter
    
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

        setupNavigationBar()
        setupCollectionView()
        setupSegmentedcontrol()
        showActivityIndicator()
        saveEvents()
        hideActivityIndicator()
    }
    
    private func showActivityIndicator() {
        collectionView.isHidden = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor).isActive = true
    }
    
    func hideActivityIndicator() {
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
        self.collectionView.isHidden = false
    }

    private func saveEvents() {
        self.dataBase.saveEvents()
        self.collectionView.reloadData()
    }
    
    private func setupNavigationBar() {
        title = "дети"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButton, style: .plain, target: self, action: #selector(popViewController))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: filterButton, style: .plain, target: nil, action: nil)
    }
    
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: "CharityEventViewCell", bundle: nil), forCellWithReuseIdentifier: "CharityEventViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = CustomColors.lightGrey
    }
    
    private func setupSegmentedcontrol() {
        segmentedControl.backgroundColor = UIColor.white
        segmentedControl.layer.borderColor = CustomColors.greenColor.cgColor
        segmentedControl.selectedSegmentTintColor = CustomColors.greenColor
        segmentedControl.layer.borderWidth = 1
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: CustomColors.greenColor]
        segmentedControl.setTitleTextAttributes(titleTextAttributes, for:.normal)
        
        let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentedControl.setTitleTextAttributes(titleTextAttributes1, for:.selected)
    }
    
    @objc private func popViewController() {
        navigationController?.popViewController(animated: true)
    }

}

extension CharityEventViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataBase.events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharityEventViewCell", for: indexPath) as? CharityEventViewCell {
            let events = dataBase.events[indexPath.item]
            cell.titleNameLabel.text = events.eventName
            cell.titleImage.image = UIImage(named: events.image ?? "test")
            cell.descriptionEventLabel.text = events.descriptionEvent
            cell.timeLeftLabel.text = events.timeLeft
            cell.backgroundColor = .white
            return cell
        }
        return UICollectionViewCell()
    }

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
        let events = self.dataBase.events[indexPath.item]
        let eventID = events.eventId
        let eventDetailsVC = EventDetailsViewController()
        eventDetailsVC.eventId = Int(eventID)
        self.navigationController?.pushViewController(eventDetailsVC, animated: true)
    }
    
}
