//
//  BaseView.swift
//  intermine-ios
//
//  Created by Nadia on 5/10/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import UIKit

class BaseView: UIView {
    
    // MARK: Constraints
    
    func constraintsToEqualDimentions(toView: UIView) -> [NSLayoutConstraint] {
        let height = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: toView, attribute: .height, multiplier: 1.0, constant: 1.0)
        let width = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: toView, attribute: .width, multiplier: 1.0, constant: 1.0)
        return [height, width]
    }
    
    // MARK: Instantiate

    class func instantiateFromNib<T: UIView>(viewType: T.Type) -> T {
        return Bundle.main.loadNibNamed(String(describing: viewType), owner: nil, options: nil)?.first as! T
    }
    
    class func instantiateFromNib() -> Self {
        return instantiateFromNib(viewType: self)
    }

}
