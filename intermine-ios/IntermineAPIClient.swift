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
    
    class func sendJSONRequest(url: String, method: HTTPMethod, params: [String: String]?, completion: @escaping (_ result: [String: AnyObject]?) -> ()) {
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        manager.request(url, method: method, parameters: params)
            .responseJSON {
                response in
                switch (response.result) {
                case .success:
                    if let JSON = response.result.value as? [String: AnyObject] {
                        completion(JSON)
                    } else {
                        completion(nil)
                    }
                    break
                case .failure(let error):
                    if error._code == NSURLErrorTimedOut {
                        // timeout
                        completion(nil)
                    }
                    completion(nil)
                    print("\n\nRequest failed with error:\n \(error)")
                    break
                }
        }
    }
    
    class func sendStringRequest(url: String, method: HTTPMethod, params: [String: String]?, completion: @escaping (_ result: String?) -> ()) {
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        manager.request(url, method: method, parameters: params)
            .responseString {
                response in
                switch (response.result) {
                case .success:
                    completion(response.value)
                    break
                case .failure(let error):
                    if error._code == NSURLErrorTimedOut {
                        // timeout
                        completion(nil)
                    }
                    completion(nil)
                    print("\n\nRequest failed with error:\n \(error)")
                    break
                }
        }
    }

    
    class func fetchRegistry(completion: (_ result: NSDictionary?) -> ()) {
        // TODO: Use registry endpoint
        // for now: read registry from .json file
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
    
    class func fetchIntermineVersion(mineUrl: String, completion: @escaping (_ result: String?) -> ()) {
        let url = mineUrl + Endpoints.intermineVersion
        IntermineAPIClient.sendJSONRequest(url: url, method: .get, params: jsonParams) { (result) in
            if let result = result {
                if let versionString = result["version"] as? String {
                    completion(versionString)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    class func fetchReleaseDate(mineUrl: String, completion: @escaping (_ result: String?) -> ()) {
        let url = mineUrl + Endpoints.modelReleased
        IntermineAPIClient.sendJSONRequest(url: url, method: .get, params: jsonParams) { (result) in
            if let result = result {
                if let releaseString = result["version"] as? String {
                    completion(releaseString)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
            
        }
    }
    
    class func fetchModel(mineUrl: String, completion: @escaping (_ result: String?) -> ()) {
        let url = mineUrl + Endpoints.modelDescription
        IntermineAPIClient.sendStringRequest(url: url, method: .get, params: nil) { (xmlString) in
            completion(xmlString)
        }
    }
    
    class func fetchLists(mineUrl: String, completion: @escaping (_ result: [List]?) -> ()) {
        let url = mineUrl + Endpoints.lists
        IntermineAPIClient.sendJSONRequest(url: url, method: .get, params: jsonParams) { (result) in
            var listObjects: [List] = []
            if let result = result {
                if let lists = result["lists"] as? [[String: AnyObject]] {
                    for list in lists {
                        let listObj = List(withTitle: list["title"] as? String,
                                           info: list["description"] as? String,
                                           size: list["size"] as? Int,
                                           type: list["type"] as? String,
                                           name: list["name"] as? String,
                                           status: list["status"] as? String)
                        listObjects.append(listObj)
                    }
                    completion(listObjects)
                }
            } else {
                completion(nil)
            }
        }
        
    }
    
    class func fetchTemplates(mineUrl: String, completion: @escaping (_ result: TemplatesList?) -> ()) {
        let url = mineUrl + Endpoints.templates
        IntermineAPIClient.sendJSONRequest(url: url, method: .get, params: jsonParams) { (result) in
            if let result = result {
                if let templates = result["templates"] as? [String: AnyObject] {
                    var templateList: [Template] = []
                    for (_, template) in templates {
                        var queryList: [TemplateQuery] = []
                        if let queries = template["where"] as? [[String: AnyObject]] {
                            for query in queries {
                                let queryObj = TemplateQuery(withValue: query["value"] as? String, code: query["code"] as? String, op: query["op"] as? String, constraint: query["path"] as? String)
                                queryList.append(queryObj)
                            }
                        }
                        let templateObj = Template(withTitle: template["title"] as? String, description: template["description"] as? String, queryList: queryList, name: template["name"] as? String, mineUrl: mineUrl)
                        templateList.append(templateObj)
                    }
                    let templatesListObj = TemplatesList(withTemplates: templateList, mine: mineUrl)
                    completion(templatesListObj)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    class func fetchTemplateResults(mineUrl: String, queryParams: [String: String], completion: @escaping (_ res: [String: AnyObject]?) -> ()) {
        let url = mineUrl + Endpoints.templateResults
        IntermineAPIClient.sendJSONRequest(url: url, method: .get, params: queryParams) { (res) in
            completion(res)
        }
    }
    
    class func getTemplateResultsCount(mineUrl: String, queryParams: [String: String], completion: @escaping (_ res: String?) -> ()) {
        let url = mineUrl + Endpoints.templateResults
        var countParams = queryParams
        countParams["format"] = "count"
        IntermineAPIClient.sendStringRequest(url: url, method: .get, params: countParams) { (res) in
            completion(res)
        }
    }
    
    // add get method, if get comes empty, do post and store token from there
    // GET - will fetch tokens from other clients
    // POST - will create token from iOS client
    // store token from GET or POST - either way it should work given the token created was PERM
    
    class func getToken(mineUrl: String, username: String, password: String) {
        
//        {"tokens":
//            [{"dateCreated":"2017-05-07T18:22:41-0400","message":"iOS client","token":"d46b67a8-f606-4e6c-b391-c6e13025a4f6"},{"dateCreated":"2017-05-08T05:48:21-0400","message":"iOS client","token":"307d2c23-39a5-4e7b-a877-9bb7961f04a4"}]
//            ,"executionTime":"2017.05.08 05:48::44","wasSuccessful":true,"error":null,"statusCode":200}
        
        var headers: HTTPHeaders = [:]
        
        if let authorizationHeader = Request.authorizationHeader(user: username, password: password) {
            headers[authorizationHeader.key] = authorizationHeader.value
        }
        
        Alamofire.request(mineUrl + Endpoints.tokens, headers: headers)
            .responseString { (response) in
                
                print(response)
                // take the token, store it in nsuserdefaults, use next time for auth
        }
    }
    
    
    class func createToken(mineUrl: String, username: String, password: String) {
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
