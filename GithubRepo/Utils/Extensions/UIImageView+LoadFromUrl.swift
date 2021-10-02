//
//  UIImageView+LoadFromUrl.swift
//  GithubRepo
//
//  Created by Marcos Alves on 02/10/21.
//

import UIKit

extension UIImageView {
    // Reference link: https://www.hackingwithswift.com/example-code/uikit/how-to-load-a-remote-image-url-into-uiimageview
    func loadFromUrl(url: String) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: URL(string: url)!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
