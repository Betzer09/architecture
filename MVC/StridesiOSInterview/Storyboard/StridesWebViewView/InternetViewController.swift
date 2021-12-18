//
//  InternetViewController.swift
//  BottleRocketCodingChallenge
//
//  Created by Austin Betzer on 4/23/21.
//

import Foundation
import UIKit
import WebKit

class InternetViewController: UIViewController {
    // MARK: - UI Properties
    private lazy var webView = {
       return WKWebView()
    }()
    
    private lazy var webViewHeader = {
        return WebViewHeader()
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = UIColor(red: 102/255, green: 224/255, blue: 185/255, alpha: 1)
        indicator.hidesWhenStopped = true
        indicator.style = .large
        return indicator
    }()
    
    
    // MARK: - View Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addWebViewObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addWebViewHeader()
        addWebView()
        addIndicator()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        loadingIndicator.stopAnimating()
    }
        
    
    private func addWebViewHeader() {
        view.addSubview(webViewHeader)
        webViewHeader.translatesAutoresizingMaskIntoConstraints = false
        webViewHeader.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webViewHeader.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        webViewHeader.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        webViewHeader.heightAnchor.constraint(equalToConstant: 100).isActive = true
        webViewHeader.setup(delegate: self)
    }
    
    private func addWebView() {
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: webViewHeader.bottomAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        if let url = URL(string: "https://www.strides.dev") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    private func addWebViewObserver() {
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    private func addIndicator() {
        view.addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingIndicator.startAnimating()
    }
}


// MARK: - WebViewHeaderDelegate
extension InternetViewController: WebViewHeaderDelegate {
    func webViewHeader(didSelectBack on: WebViewHeader) {
        webView.goBack()
    }
    
    func webViewHeader(didSelectForward on: WebViewHeader) {
        webView.goForward()
    }
    
    func webViewHeader(didSelectRefresh on: WebViewHeader) {
        webView.reload()
    }
    
}
