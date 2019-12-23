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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = themeColor
        delegate = self
        api.getToken { (response) in
            print(response)
            
            
            
            let item1 = ViewController()
            let firstVc = UINavigationController(rootViewController: item1)
            let icon1 = UITabBarItem(title: "home", image: nil, tag: 0)
            item1.tabBarItem = icon1
            let item2 = SearchViewController()
            let secondVc = UINavigationController(rootViewController: item2)
            let icon2 = UITabBarItem(title: "search", image: nil, tag: 1)
            item2.tabBarItem = icon2
            let item3 = playerViewController()
            item3.initNotif()
            let icon3 = UITabBarItem(title: "player", image: nil, tag: 2)
            item3.tabBarItem = icon3
            let controllers = [firstVc,secondVc,item3]  //array of the root view controllers displayed by the tab bar interface
            self.viewControllers = controllers
        }
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
