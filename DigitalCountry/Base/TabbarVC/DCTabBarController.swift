//
//  DCTabBarController.swift
//  DigitalCountry
//
//  Created by 倪尛 on 2022/9/6.
//
import Foundation
import UIKit

class DCTabBarController: UITabBarController, UITabBarControllerDelegate {

    var homeNavigationController : BaseNavigationController!
    var homePageVC : HomePageVController!
    var discoveryVC : DiscoveryVController!
    var goodsMallVC : GoodsMallVController!
    var mineInfoVC : MineInfoVController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        tabBar.barTintColor = .black
        tabBar.isTranslucent = false
        tabBar.unselectedItemTintColor = .gray
        tabBar.tintColor = .white
        
        homePageVC = HomePageVController()
        homeNavigationController = BaseNavigationController(rootViewController: homePageVC)
        discoveryVC = DiscoveryVController()
        goodsMallVC = GoodsMallVController()
        mineInfoVC = MineInfoVController()
        
        
        homePageVC.tabBarItem.image = UIImage(systemName: "house")
        homePageVC.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        discoveryVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        discoveryVC.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass")
        
        
        goodsMallVC.tabBarItem.image = UIImage(systemName: "text.bubble")
        goodsMallVC.tabBarItem.selectedImage = UIImage(systemName: "text.bubble.fill")
        
        mineInfoVC.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        mineInfoVC.tabBarItem.selectedImage = UIImage(systemName: "person.crop.circle.fill")
        
        viewControllers = [homeNavigationController, discoveryVC, goodsMallVC, mineInfoVC]
        let tabBarItemTitles = ["首页","发现","消息","我"]
        for (index, tabBarItem) in tabBar.items!.enumerated() {
            tabBarItem.title = tabBarItemTitles[index]
            
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }

}
