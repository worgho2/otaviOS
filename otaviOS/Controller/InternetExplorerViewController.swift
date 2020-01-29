//
//  InternetExplorerViewController.swift
//  otaviOS
//
//  Created by Otavio on 29/01/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import UIKit
import WebKit

class InternetExplorerViewController: BaseViewController, WKNavigationDelegate {
    
    @IBOutlet weak var internetExplorerView: UIView!
    @IBOutlet weak var internetExplorerWKWebView: WKWebView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var internetExplorerTitleLabel: UILabel!
    @IBOutlet weak var internetExplorerActivityIndicator: UIActivityIndicatorView!
    
    override func loadView() {
        super.loadView()
        self.internetExplorerWKWebView.navigationDelegate = self
        self.internetExplorerWKWebView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://google.com")!
        self.internetExplorerWKWebView.load(URLRequest(url: url))
    }
    
    @IBAction func onClose(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        internetExplorerTitleLabel.text = "Internet Explorer - " + webView.title!
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            if internetExplorerWKWebView.estimatedProgress < 0.85 {
                internetExplorerActivityIndicator.startAnimating()
                internetExplorerActivityIndicator.isHidden = false
            } else {
                internetExplorerActivityIndicator.stopAnimating()
                internetExplorerActivityIndicator.isHidden = true
            }
        }
    }
    
}
