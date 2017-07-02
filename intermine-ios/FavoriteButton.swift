//
//  ImageBarItem.swift
//  intermine-ios
//
//  Created by Nadia on 7/1/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import UIKit

class FavoriteButton: UIButton {
    
    private let selectedImage: UIImage = Icons.bookmark
    private let deselectedImage: UIImage = Icons.bookmarkEmpty
    
    private var isFavorite: Bool {
        didSet {
            if self.isFavorite {
                self.setImage(selectedImage, for: .normal)
            } else {
                self.setImage(deselectedImage, for: .normal)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        self.isFavorite = false
        super.init(frame: frame)
        self.addTarget(self, action: #selector(FavoriteButton.tapped), for: .touchUpInside)
    }
    
    convenience init(isFavorite: Bool) {
        self.init(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        self.changeSelectedState(isFavorite: isFavorite)
    }

    func changeSelectedState(isFavorite: Bool) {
        self.isFavorite = isFavorite
    }
    
    func tapped() {
        print ("tapped")
    }

}
