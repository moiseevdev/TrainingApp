//
//  CharityEventViewController.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 01.10.2021.
//

import UIKit

final class CharityEventViewController: UIViewController {

    var categoryId: Int?
    
    private var networkService = NetworkService()
    private var dataBase = DataBaseAdapter.dataBase
    
    private var events: [EventModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.hideActivityIndicator()
            }
        }
    }

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
        setupNavigationBar()
        setupCollectionView()
        setupSegmentedcontrol()
        showActivityIndicator()
        
        networkService.fethEvents { result in
            switch result {
            case .success(let networkResponse):
                self.events = networkResponse.map({ EventModel(eventID: $0.eventID,
                                                               eventName: $0.eventName,
                                                               image: $0.image,
                                                               descriptionEvent: $0.descriptionEvent,
                                                               timeLeft: $0.timeLeft,
                                                               address: $0.address,
                                                               number: $0.number,
                                                               email: $0.email,
                                                               image1: $0.image1,
                                                               image2: $0.image2,
                                                               image3: $0.image3,
                                                               description1: $0.description1,
                                                               description2: $0.description2,
                                                               website: $0.website) })
            case .failure:
                self.dataBase.getEvents { result in
                    switch result {
                    case .success(let coredataResponse):
                        self.events = coredataResponse
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    
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
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        collectionView.isHidden = false
    }
    
    private func setupNavigationBar() {
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

// MARK: - UICollectionViewDataSource
extension CharityEventViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharityEventViewCell", for: indexPath) as? CharityEventViewCell {
            let events = events[indexPath.item]
            cell.titleNameLabel.text = events.eventName
            cell.titleImage.setImage(imageUrl: events.image ?? "test")
            cell.descriptionEventLabel.text = events.descriptionEvent
            cell.timeLeftLabel.text = events.timeLeft
            cell.backgroundColor = .white
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
        let events = events[indexPath.item]
        guard let eventID = events.eventID else { return }
        let eventDetailsVC = EventDetailsViewController()
        eventDetailsVC.eventId = eventID
        navigationController?.pushViewController(eventDetailsVC, animated: true)
    }
    
}
