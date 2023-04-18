//
//  RSSItem.swift
//  ImageOfTheDay
//
//  Created by Idan Israel on 17/04/2023.
//

import Foundation

struct RSSItem: Codable {
    
    var title: String
    var link: String
    var description: String
    var pubDate: String
    var enclosure: String
}
