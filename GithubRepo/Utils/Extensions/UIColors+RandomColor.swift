//
//  UIColors+RandomColor.swift
//  GithubRepo
//
//  Created by Marcos Alves on 02/10/21.
//

import UIKit

extension UIColor {
    // Reference Link: https://gist.github.com/skreutzberger/32be80e2ebef71dfb793
    static var randomColor: UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
