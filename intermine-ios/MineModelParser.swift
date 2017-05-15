//
//  MineModelParser.swift
//  intermine-ios
//
//  Created by Nadia on 5/15/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import Foundation
import SWXMLHash

class MineModelParser: NSObject {
    
    private var xml: XMLIndexer?
    
    override init() {
        self.xml = nil
    }
    
    convenience init(fromFileWithName fileName: String) {
        self.init()
        if let xmlString = FileHandler.readFromFile(fileName: fileName) {
            self.xml = SWXMLHash.lazy(xmlString)
            
        }
    }
    
    func findElementByType(type: String) {
        guard let xml = self.xml else {
            return
        }
        
        do {
            let elem = try xml["model"]["class"].withAttr("name", type).element
            print(elem)
        } catch let error as NSError {
            print("error parsing xml: \(error)")
        }
    }
    
}
