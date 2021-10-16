//
//  AboutViewController.swift
//  GithubRepo
//
//  Created by Marcos Alves on 07/09/21.
//

import UIKit

class AboutViewController: UIViewController {
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }

    // MARK: - Setup

    func prepareUI() {
        navigationItem.title = "About"
    }
}
