//
//  BaseView.swift
//  intermine-ios
//
//  Created by Nadia on 5/10/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import UIKit

class BaseView: UIView {
    
    // MARK: Instantiate

    class func instantiateFromNib<T: UIView>(viewType: T.Type) -> T {
        return Bundle.main.loadNibNamed(String(describing: viewType), owner: nil, options: nil)?.first as! T
    }
    
    class func instantiateFromNib() -> Self {
        return instantiateFromNib(viewType: self)
    }
    
    // MARK: Public methods
    
    public func resizeView(toY: CGFloat, toWidth: CGFloat, toHeight: CGFloat) {
        self.frame = CGRect(x: 0, y: toY, width: toWidth, height: toHeight)
        self.layoutIfNeeded()
    }

}
