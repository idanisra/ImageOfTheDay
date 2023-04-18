//
//  CustomActivityIndicator.swift
//  ImageOfTheDay
//
//  Created by Idan Israel on 18/04/2023.
//

import UIKit
import Kingfisher

struct CustomActivityIndicator: Indicator {
    
    let activityIndicator = UIActivityIndicatorView()
    let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))

    func startAnimatingView() { view.isHidden = false }
    func stopAnimatingView() { view.isHidden = true }
    
    init() {
        view.backgroundColor = UIColor.clear
        view.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        activityIndicator.style = .large
        activityIndicator.color = .link
        activityIndicator.startAnimating()
    }
}
