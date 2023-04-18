//
//  LinkOpenerViewController.swift
//  ImageOfTheDay
//
//  Created by Idan Israel on 18/04/2023.
//

import UIKit
import WebKit

class LinkOpenerViewController: UIViewController {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var activityView: UIView! {
        didSet {
            activityView.layer.cornerRadius = 15.0
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var webView : WKWebView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    // MARK: - Public Functions
    
    func open(urlAddress: String) {
        
        guard let url = URL(string: urlAddress) else { return }

        activityView.isHidden = false
        webView = WKWebView()
        webView.navigationDelegate = self
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}

extension LinkOpenerViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        activityView.isHidden = true
        view = webView
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        activityView.isHidden = true
    }
}

