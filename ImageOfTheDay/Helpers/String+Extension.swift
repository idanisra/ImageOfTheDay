//
//  String+Extension.swift
//  ImageOfTheDay
//
//  Created by Idan Israel on 17/04/2023.
//

import Foundation

extension String {
    
    mutating func parseNewLines() {
        self = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func number() -> Double? {
        return Double(self)
    }
}
