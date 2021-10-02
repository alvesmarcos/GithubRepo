//
//  Int+ConventIntoAFriendlyKMAbbr.swift
//  GithubRepo
//
//  Created by Marcos Alves on 01/10/21.
//

import Foundation

extension Int {
    // Reference link: https://stackoverflow.com/questions/36376897/swift-2-0-format-1000s-into-a-friendly-ks/36377091
    var kmAbbreviation: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(self)"
        }
    }
}
