//
//  WebViewController.swift
//  intermine-ios
//
//  Created by Nadia on 5/25/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import UIKit

class WebViewController: BaseViewController, UIWebViewDelegate {
    
    
    @IBOutlet weak var webView: UIWebView?
    
    private var urlString: String?
    
    private var searchResult: SearchResult? {
        didSet {
            if let searchResult = self.searchResult,
                let mineName = searchResult.getMineName(),
                let id = searchResult.getId() {
                if let mine = CacheDataStore.sharedCacheDataStore.findMineByName(name: mineName) {
                    if let mineUrl = mine.url {
                        let urlString = mineUrl + Endpoints.report + "?id=\(id)"
                        if let url = NSURL(string: urlString) as URL? {
                            let request = NSURLRequest(url: url)
                            self.webView?.loadRequest(request as URLRequest)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: Load from storyboard
    
    class func webViewController(withSearchResult: SearchResult) -> WebViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WebVC") as? WebViewController
        vc?.searchResult = withSearchResult
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView?.delegate = self
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("error: \(error)")
    }
    
    


}
