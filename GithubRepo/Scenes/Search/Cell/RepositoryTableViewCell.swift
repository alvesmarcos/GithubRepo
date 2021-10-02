//
//  RepositoryTableViewCell.swift
//  GithubRepo
//
//  Created by Marcos Alves on 29/09/21.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    private(set) var repository: Repository?
    
    // MARK: - UI Elements
    
    @IBOutlet weak var ownerLabel: UILabel?
    @IBOutlet weak var repositoryNameLabel: UILabel?
    @IBOutlet weak var descriptionLabel: UILabel?
    @IBOutlet weak var languageLabel: UILabel?
    @IBOutlet weak var starsLabel: UILabel?
    @IBOutlet weak var avatarImage: UIImageView?
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.repository = nil
    }
    
    // MARK: - Setup
    
    private func prepareUI() {
        avatarImage?.layer.cornerRadius = 25
    }
    
    // MARK: - Helpers
    
    func setupCell(with repository: Repository) {
        self.repository = repository
        
        ownerLabel?.text = repository.owner.login
        repositoryNameLabel?.text = repository.name
        descriptionLabel?.text = repository.description
        languageLabel?.text = repository.language
        starsLabel?.text = repository.stars.kmAbbreviation
        avatarImage?.loadFromUrl(url: repository.owner.avatarUrl)
    }
}
