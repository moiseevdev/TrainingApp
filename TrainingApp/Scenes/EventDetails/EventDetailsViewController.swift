//
//  EventDetailsViewController.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 01.10.2021.
//

import UIKit

final class EventDetailsViewController: UIViewController {
    
    var eventId: Int?
    
    private var networkService = URLSessionService()
    private var dataBase = DataBaseAdapter.dataBase
    
    private var events: [EventModel] = [] {
        didSet {
            self.setuphData()
            self.hideActivityIndicator()
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var firstImageLabel: UIImageView!
    @IBOutlet weak var secondImageLabel: UIImageView!
    @IBOutlet weak var thirdImageLabel: UIImageView!
    @IBOutlet weak var firstDescriptionLabel: UILabel!
    @IBOutlet weak var secondDescriptionLabel: UILabel!
    @IBOutlet weak var actionsView: UIView!
    
    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .medium
        activityIndicator.color = .black
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private let backButtonImage = Images.rectangle7
    private let shareButtonImage = Images.iconShare

    override func viewDidLoad() {
        super.viewDidLoad()
        titleNameLabel.font = CustomFonts.OfficinasansextraboldsccFont21
        titleNameLabel.textColor = CustomColors.blueGrey
        setupNavigationController()
        showtActivityIndicator()
        fethEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    
}

// MARK: - Private methods
private extension EventDetailsViewController {
    
    func showtActivityIndicator() {
        scrollView.isHidden = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    func fethEvents() {
        networkService.fethEvents { [weak self] result in
            switch result {
            case .success(let networkResponse):
                self?.events = networkResponse.map({ EventModel(eventId: $0.eventId,
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
                self?.dataBase.getEvents { result in
                    switch result {
                    case .success(let coredataResponse):
                        self?.events = coredataResponse
                    case .failure:
                        self?.showErrorAlert()
                    }
                }
            }
        }
    }
    
    func setuphData() {
        title = events[eventId ?? 1].eventName
        titleNameLabel.text = events[eventId ?? 1].eventName
        timeLeftLabel.text = events[eventId ?? 1].timeLeft
        addressLabel.text = events[eventId ?? 1].address
        numberLabel.text = events[eventId ?? 1].number
        firstImageLabel.setImage(imageUrl: events[eventId ?? 1].image1 ?? "test")
        secondImageLabel.setImage(imageUrl: events[eventId ?? 1].image2 ?? "test")
        thirdImageLabel.setImage(imageUrl: events[eventId ?? 1].image3 ?? "test")
        firstDescriptionLabel.text = events[eventId ?? 1].description1
        secondDescriptionLabel.text = events[eventId ?? 1].description2
    }
    
    func hideActivityIndicator() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        scrollView.isHidden = false
    }
    
    func setupNavigationController() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(popViewController))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: shareButtonImage,
                                                            style: .plain,
                                                            target: nil,
                                                            action: nil)
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "Failed to get data", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func popViewController() {
        navigationController?.popViewController(animated: true)
        tabBarController?.tabBar.isHidden = false
    }
}
