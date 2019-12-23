//
//  MainControllerViewController.swift
//  ProgMobile
//
//  Created by Alexendre on 13/12/2019.
//  Copyright © 2019 Alexendre. All rights reserved.
//

import UIKit

let themeColor = UIColor.black

class MainControllerViewController: UITabBarController, UITabBarControllerDelegate {
    let api = apiLooker()
    let noNetworkView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = themeColor
        self.tabBar.barStyle = .black
        delegate = self
        
        let indication = UILabel()
        indication.text = "pas de connexion à internet"
        indication.backgroundColor = UIColor.white
        noNetworkView.frame = self.view.frame
        indication.frame = noNetworkView.frame
        indication.textAlignment = .center
        noNetworkView.addSubview(indication)
        
        if Reachability.isConnectedToNetwork() {
            print("connected")
            noNetworkView.removeFromSuperview()
            LoadViews()
         } else {
            print("not connected")
            self.view.addSubview(noNetworkView)
            checkReach()
        }

    }
    
    func checkReach(){
        if Reachability.isConnectedToNetwork() {
            noNetworkView.removeFromSuperview()
             LoadViews()
         } else {
            checkReach()
        }
    }
    
    func LoadViews(){
        api.getToken { (response) in
            print(response)
            
            let item1 = ViewController()
            let firstVc = UINavigationController(rootViewController: item1)
            firstVc.navigationBar.barStyle = .blackTranslucent
            firstVc.navigationBar.topItem?.title = "Spotif'Esiea !"
            let icon1 = UITabBarItem(title: "home", image: UIImage.init(imageLiteralResourceName: "homeIcon"), tag: 0)
            item1.tabBarItem = icon1
            let item2 = SearchViewController()
            let secondVc = UINavigationController(rootViewController: item2)
            secondVc.title = "SearchPlayer"
            secondVc.navigationBar.barStyle = .blackTranslucent
            let icon2 = UITabBarItem(title: "search", image: UIImage.init(imageLiteralResourceName: "searchIcon"), tag: 1)
            item2.tabBarItem = icon2
            let item3 = playerViewController()
            item3.initNotif()
            let icon3 = UITabBarItem(title: "player", image: UIImage.init(imageLiteralResourceName: "playerIcon"), tag: 2)
            item3.tabBarItem = icon3
            NotificationCenter.default.addObserver(self, selector: #selector(self.setNotif), name: NSNotification.Name(rawValue: "notificationName"), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.unsetNotif), name: NSNotification.Name(rawValue: "removeNotif"), object: nil)
            let controllers = [firstVc,secondVc,item3]  //array of the root view controllers displayed by the tab bar interface
            self.viewControllers = controllers
        }
    }
    
    @objc func setNotif(){
        self.tabBar.items?.last?.badgeValue = "Loading.."
    }
    
    @objc func unsetNotif(){
        self.tabBar.items?.last?.badgeValue = "Playing"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true;
    }
}
