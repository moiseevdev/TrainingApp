//
//  EventDetailsViewController.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 01.10.2021.
//

import UIKit

class EventDetailsViewController: UIViewController {
    
    private var dataBase = DataBaseAdapter.dataBase
    
    var eventId: Int!
    
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
    
    private let backButton = Images.rectangle7
    private let shareButton = Images.iconShare

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
    
    func hideActivityIndicator() {
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
        self.scrollView.isHidden = false
    }

    private func fetchData() {
        titleNameLabel.text = self.dataBase.events[self.eventId].eventName
        timeLeftLabel.text = self.dataBase.events[self.eventId].timeLeft
        addressLabel.text = self.dataBase.events[self.eventId].address
        numberLabel.text = self.dataBase.events[self.eventId].number
        firstImageLabel.image = UIImage(named: "\(self.dataBase.events[self.eventId].image1 ?? "test")")
        secondImageLabel.image = UIImage(named: "\(self.dataBase.events[self.eventId].image2 ?? "test")")
        thirdImageLabel.image = UIImage(named: "\(self.dataBase.events[self.eventId].image3 ?? "test")")
        firstDescriptionLabel.text = self.dataBase.events[self.eventId].description1
        secondDescriptionLabel.text = self.dataBase.events[self.eventId].description2
    }
    
    private func setupNavigationController() {
        self.title = dataBase.events[self.eventId!].eventName
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButton, style: .plain, target: self, action: #selector(popViewController))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: shareButton, style: .plain, target: nil, action: nil)
    }
    
    @objc private func popViewController() {
        navigationController?.popViewController(animated: true)
        tabBarController?.tabBar.isHidden = false
    }
}
