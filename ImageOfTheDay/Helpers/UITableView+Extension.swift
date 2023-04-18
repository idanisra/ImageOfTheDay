//
//  UITableView+Extension.swift
//  ImageOfTheDay
//
//  Created by Idan Israel on 17/04/2023.
//

import UIKit

// MARK: - UITableView extension

extension UITableView {
    func setupTableView(parentVC: UIViewController, nibName: String, separatorStyle: UITableViewCell.SeparatorStyle  = .none ) {
        self.delegate = parentVC as? UITableViewDelegate
        self.dataSource = parentVC as? UITableViewDataSource
        
        let cellNib = UINib(nibName: nibName, bundle: nil)
        self.register(cellNib, forCellReuseIdentifier: nibName)
        
        self.tableFooterView = UIView()
        self.separatorStyle = separatorStyle
    }
}
