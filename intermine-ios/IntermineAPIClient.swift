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
    
    static let jsonParams = ["format": "json"]
    
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
        
    class func fetchModel(mineUrl: String) {
        // send GET request to mineUrl + /model endpoint
        Alamofire.request(mineUrl + Endpoints.modelDescription, parameters: jsonParams).responseJSON { (response) in
            print(response.result)
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
    
    class func fetchLists(mineUrl: String) {
        Alamofire.request(mineUrl + Endpoints.lists, parameters: jsonParams).responseJSON { (response) in
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
    
    class func fetchTemplates(mineUrl: String) {
        Alamofire.request(mineUrl + Endpoints.templates, parameters: jsonParams).responseJSON { (response) in
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
    
    class func getToken(mineUrl: String, username: String, password: String) {
        //                SUCCESS: {
        //                    error = "<null>";
        //                    executionTime = "2017.05.07 18:22::41";
        //                    statusCode = 200;
        //                    token = "d46b67a8-f606-4e6c-b391-c6e13025a4f6";
        //                    wasSuccessful = 1;
        //                }

        var headers: HTTPHeaders = [:]
        
        if let authorizationHeader = Request.authorizationHeader(user: username, password: password) {
            headers[authorizationHeader.key] = authorizationHeader.value
        }
        
        let params = ["type": "perm", "message": "iOS client"]
        
        Alamofire.request(mineUrl + Endpoints.tokens, method: .post, parameters: params, headers: headers)
            .responseJSON { (response) in
                
            print(response)
            // take the token, store it in nsuserdefaults, use next time for auth
        }
    }
    
}
