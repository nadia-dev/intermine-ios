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
    
    // MARK: Load from storyboard
    
    class func webViewController() -> WebViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WebVC") as? WebViewController
        return vc
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let url = NSURL(string: "http://www.mousemine.org/mousemine/report.do?id=12915318") as URL? {
            let request = NSURLRequest(url: url)
            self.webView?.loadRequest(request as URLRequest)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView?.delegate = self
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("error: \(error)")
    }
    
    


}
