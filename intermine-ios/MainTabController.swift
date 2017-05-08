//
//  ViewController.swift
//  intermine-ios
//
//  Created by Nadia on 4/1/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import UIKit
import Font_Awesome_Swift

class MainTabController: UITabBarController {

    @IBOutlet weak var bar: UITabBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBar()
    }

    // MARK: Private methods
    
    private func setupTabBar() {
        guard let items = bar?.items else {
            return
        }
        let images = [UIImage.init(icon: .FASearch, size: CGSize(width: 35, height: 35)),
                      UIImage.init(icon: .FATasks, size: CGSize(width: 35, height: 35)),
                      UIImage.init(icon: .FAList, size: CGSize(width: 35, height: 35)),
                      UIImage.init(icon: .FABookmark, size: CGSize(width: 35, height: 35)),
                      UIImage.init(icon: .FASignIn, size: CGSize(width: 35, height: 35))]
        let titles = ["Search", "Templates", "Lists", "Favorites", "Login"]
        
        for i in 0..<items.count {
            items[i].image = images[i]
            items[i].title = titles[i]
        }
    }

}

