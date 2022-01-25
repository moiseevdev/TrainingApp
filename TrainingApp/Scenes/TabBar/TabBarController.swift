//
//  TabBarController.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 26.09.2021.
//

import UIKit

// MARK: - TabBarController
final class TabBarController: UITabBarController {
    
    private let assemblyService = SceneAssemblyService()
    
    private let middleButtonDiameter: CGFloat = 42
    private let redColor: UIColor = CustomColors.redColor
    private let greenColor: UIColor = CustomColors.greenColor

    private lazy var middleButton: UIButton = {
        let middleButton = UIButton()
        middleButton.layer.cornerRadius = middleButtonDiameter / 2
        middleButton.backgroundColor = redColor
        middleButton.translatesAutoresizingMaskIntoConstraints = false
        middleButton.addTarget(self, action: #selector(didPressMiddleButton), for: .touchUpInside)
        return middleButton
    }()
    
    private lazy var heartImageView: UIImageView = {
        let heartImageView = UIImageView()
        heartImageView.image = Images.heartFill
        heartImageView.tintColor = .white
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        return heartImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    @objc
    func didPressMiddleButton() {
        selectedIndex = 2
        middleButton.backgroundColor = greenColor
    }
}

// MARK: - Private methods
private extension TabBarController {
    
    func setupUI() {
        addSubviews()
        
        let newsViewController = TestViewController()
        newsViewController.tabBarItem.title = Strings.news
        newsViewController.tabBarItem.image = Images.listBullet
        
        let searchViewController = TestViewController()
        searchViewController.tabBarItem.title = Strings.search
        searchViewController.tabBarItem.image = Images.magnifyingglass
        
        let categoriesViewController = UINavigationController(rootViewController: assemblyService.buildCategoriesModule())
        guard let font = CustomFonts.OfficinasansextraboldsccFont21 else {
            return
        }
        let appearanceNavigationBar =  UINavigationBar.appearance()
        appearanceNavigationBar.barTintColor = CustomColors.greenColor
        appearanceNavigationBar.titleTextAttributes = [.font: font, .foregroundColor: UIColor.white]
        let appearanceTabBar = UITabBar.appearance()
        appearanceTabBar.tintColor = CustomColors.greenColor
        categoriesViewController.tabBarItem.title = Strings.help
        
        let historyViewController = TestViewController()
        historyViewController.tabBarItem.title = Strings.history
        historyViewController.tabBarItem.image = Images.clockArrowCirclepath
        
        let profileViewController = TestViewController()
        profileViewController.tabBarItem.title = Strings.profile
        profileViewController.tabBarItem.image = Images.personCropCircle
        
        viewControllers = [newsViewController, searchViewController, categoriesViewController, historyViewController, profileViewController]
    }
    
    func addSubviews() {
        tabBar.addSubview(middleButton)
        middleButton.addSubview(heartImageView)
        
        NSLayoutConstraint.activate([
            middleButton.heightAnchor.constraint(equalToConstant: middleButtonDiameter),
            middleButton.widthAnchor.constraint(equalToConstant: middleButtonDiameter),
            middleButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            middleButton.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            heartImageView.heightAnchor.constraint(equalToConstant: 15),
            heartImageView.widthAnchor.constraint(equalToConstant: 18),
            heartImageView.centerXAnchor.constraint(equalTo: middleButton.centerXAnchor),
            heartImageView.centerYAnchor.constraint(equalTo: middleButton.centerYAnchor)
        ])
    }
}

// MARK: - UITabBarControllerDelegate
extension TabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let selectedIndex = self.tabBar.items?.firstIndex(of: item)
        if selectedIndex == 2 {
            middleButton.backgroundColor = greenColor
        } else {
            middleButton.backgroundColor = redColor
        }
    }
}
