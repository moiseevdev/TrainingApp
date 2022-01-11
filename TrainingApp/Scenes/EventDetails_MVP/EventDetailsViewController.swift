//
//  EventDetailsViewController.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 01.10.2021.
//

import UIKit

protocol EventDetailsViewProtocol: AnyObject {
    func setuphData(data: [EventModel])
    func hideActivityIndicator()
    func showErrorAlert()
}

final class EventDetailsViewController: UIViewController {
    
    var eventId: Int?
    
    var presenter: EventDetailsProtocol!
    
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
        presenter = EventDetailsPresenter()
        titleNameLabel.font = CustomFonts.OfficinasansextraboldsccFont21
        titleNameLabel.textColor = CustomColors.blueGrey
        setupNavigationController()
        showtActivityIndicator()
        presenter.fethEvents()
        //presenter.setupData()
        hideActivityIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    
}

extension EventDetailsViewController: EventDetailsViewProtocol {
    
    func showtActivityIndicator() {
        scrollView.isHidden = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    
    func setuphData(data: [EventModel]) {
        print("test")
        title = data[eventId ?? 1].eventName
        titleNameLabel.text = data[eventId ?? 1].eventName
        timeLeftLabel.text = data[eventId ?? 1].timeLeft
        addressLabel.text = data[eventId ?? 1].address
        numberLabel.text = data[eventId ?? 1].number
        firstImageLabel.setImage(imageUrl: data[eventId ?? 1].image1 ?? "test")
        secondImageLabel.setImage(imageUrl: data[eventId ?? 1].image2 ?? "test")
        thirdImageLabel.setImage(imageUrl: data[eventId ?? 1].image3 ?? "test")
        firstDescriptionLabel.text = data[eventId ?? 1].description1
        secondDescriptionLabel.text = data[eventId ?? 1].description2
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
