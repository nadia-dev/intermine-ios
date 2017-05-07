//
//  IntermineAPIClient.swift
//  intermine-ios
//
//  Created by Nadia on 4/25/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import Foundation
import Alamofire

class IntermineAPIClient: NSObject {
    
    class func fetchRegistry(completion: (_ result: NSDictionary?) -> ()) {
        // TODO: Use registry endpoint
        //for now: read registry from .json file
        let registryPath = Bundle.main.path(forResource: "registry", ofType: ".json")
        
        guard let jsonData = try? NSData(contentsOfFile: registryPath!, options: NSData.ReadingOptions.mappedIfSafe) else {
            completion(nil)
            return
        }
        
        if let jsonResult = try? JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
            completion(jsonResult)
        } else {
            completion(nil)
        }
        
    }
    
    
}
