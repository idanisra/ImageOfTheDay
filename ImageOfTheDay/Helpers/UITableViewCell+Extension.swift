//
//  UITableViewCell+Extension.swift
//  ImageOfTheDay
//
//  Created by Idan Israel on 17/04/2023.
//

import UIKit

// MARK: - UITableView extension

extension UITableViewCell {
    static func getReusableIdentifier() -> String {
        return String(describing: self)
    }
}
