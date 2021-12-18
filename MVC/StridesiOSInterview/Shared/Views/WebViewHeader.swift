//
//  WebViewHeader.swift
//  BottleRocketCodingChallenge
//
//  Created by Interviewee on 4/23/21.
//

import Foundation
import UIKit

protocol WebViewHeaderDelegate: class {
    func webViewHeader(didSelectBack on: WebViewHeader)
    func webViewHeader(didSelectForward on: WebViewHeader)
    func webViewHeader(didSelectRefresh on: WebViewHeader)
}

class WebViewHeader: UIView {
    // MARK: - Private
    private weak var delegate: WebViewHeaderDelegate?
    
    // MARK: - UI Setup
    func setup(delegate: WebViewHeaderDelegate) {
        self.delegate = delegate
        layoutView()
    }

    private func layoutView() {
        let view = self
        
        // Add background
        let backgroundView =  UIView()
        view.addSubview(backgroundView)
        backgroundView.backgroundColor = UIColor(red: 102/255, green: 224/255, blue: 185/255, alpha: 1)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // Stack view
        let stackView = UIStackView()
        backgroundView.addSubview(stackView)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        stackView.heightAnchor.constraint(equalTo: backgroundView.heightAnchor, multiplier: 0.7).isActive = true
        
        // back button
        let backButton = UIButton()
        stackView.addArrangedSubview(backButton)
        backButton.setImage(UIImage(named: "ic_webBack"), for: .normal)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        let refreshButton = UIButton()
        stackView.addArrangedSubview(refreshButton)
        refreshButton.setImage(UIImage(named: "ic_webRefresh"), for: .normal)
        refreshButton.addTarget(self, action: #selector(refreshAction), for: .touchUpInside)
        
        // forward button
        let forwardButton = UIButton()
        stackView.addArrangedSubview(forwardButton)
        forwardButton.setImage(UIImage(named: "ic_webForward"), for: .normal)
        forwardButton.addTarget(self, action: #selector(forwardAction), for: .touchUpInside)
    }
    
    // MARK: - Private 
    @objc private func refreshAction() {
        delegate?.webViewHeader(didSelectRefresh: self)
    }
    
    @objc private func forwardAction() {
        delegate?.webViewHeader(didSelectForward: self)
    }
    
    @objc private func backAction() {
        delegate?.webViewHeader(didSelectBack: self)
    }
}
