//
//  TabBarController.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 26.09.2021.
//

import UIKit

final class TabBarController: UITabBarController {
    
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
        heartImageView.image = UIImage(systemName: "heart.fill")
        heartImageView.tintColor = .white
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        return heartImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
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

        let newsViewController = TestViewController()
        newsViewController.tabBarItem.title = "Новости"
        newsViewController.tabBarItem.image = UIImage(systemName: "list.bullet")

        let searchViewController = TestViewController()
        searchViewController.tabBarItem.title = "Поиск"
        searchViewController.tabBarItem.image = UIImage(systemName: "magnifyingglass")

        let categoriesViewController = UINavigationController(rootViewController: CategoriesViewController())
        guard let font = CustomFonts.OfficinasansextraboldsccFont21 else { return }
        let appearanceNavigationBar =  UINavigationBar.appearance()
        appearanceNavigationBar.barTintColor = CustomColors.greenColor
        appearanceNavigationBar.titleTextAttributes = [.font: font, .foregroundColor: UIColor.white]
        let appearanceTabBar = UITabBar.appearance()
        appearanceTabBar.tintColor = CustomColors.greenColor
        categoriesViewController.tabBarItem.title = "Помочь"
        
        let historyViewController = TestViewController()
        historyViewController.tabBarItem.title = "История"
        historyViewController.tabBarItem.image = UIImage(systemName: "clock.arrow.circlepath")

        let profileViewController = TestViewController()
        profileViewController.tabBarItem.title = "Профиль"
        profileViewController.tabBarItem.image = UIImage(systemName: "person.crop.circle")

        viewControllers = [newsViewController, searchViewController, categoriesViewController, historyViewController, profileViewController]
    }

    @objc
    func didPressMiddleButton() {
        selectedIndex = 2
        middleButton.backgroundColor = greenColor
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
