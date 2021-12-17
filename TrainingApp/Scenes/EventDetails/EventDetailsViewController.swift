//
//  EventDetailsViewController.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 01.10.2021.
//

import UIKit

final class EventDetailsViewController: UIViewController {
    
    private var dataBase = DataBaseAdapter.dataBase
    
    var eventId: Int?
    
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
        fetchData()
        hideActivityIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    private func showtActivityIndicator() {
        scrollView.isHidden = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func hideActivityIndicator() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        scrollView.isHidden = false
    }

    private func fetchData() {
        titleNameLabel.text = dataBase.events[self.eventId ?? 1].eventName
        timeLeftLabel.text = dataBase.events[self.eventId ?? 1].timeLeft
        addressLabel.text = dataBase.events[self.eventId ?? 1].address
        numberLabel.text = dataBase.events[self.eventId ?? 1].number
        firstImageLabel.image = UIImage(named: "\(dataBase.events[self.eventId ?? 1].image1 ?? "test")")
        secondImageLabel.image = UIImage(named: "\(dataBase.events[self.eventId ?? 1].image2 ?? "test")")
        thirdImageLabel.image = UIImage(named: "\(dataBase.events[self.eventId ?? 1].image3 ?? "test")")
        firstDescriptionLabel.text = dataBase.events[self.eventId ?? 1].description1
        secondDescriptionLabel.text = dataBase.events[self.eventId ?? 1].description2
    }
    
    private func setupNavigationController() {
        title = dataBase.events[eventId!].eventName
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(popViewController))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: shareButtonImage,
                                                            style: .plain,
                                                            target: nil,
                                                            action: nil)
    }
    
    @objc private func popViewController() {
        navigationController?.popViewController(animated: true)
        tabBarController?.tabBar.isHidden = false
    }
}
