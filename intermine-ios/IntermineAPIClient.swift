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
    
    static let mouseMine: Mine? = CacheDataStore.sharedCacheDataStore.getMouseMine()
    
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
    
    class func fetchMouseModel() {
        guard let mineUrl = self.mouseMine?.url else {
            return
        }
        fetchModel(mineUrl: mineUrl)
    }
    
    class func fetchModel(mineUrl: String) {
        // send GET request to mineUrl + /model endpoint
        let params = ["format": "json"]
        Alamofire.request(mineUrl + Endpoints.modelDescription, parameters: params).responseJSON { (response) in
            print(response.result)
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
        
    }
    
    
}
