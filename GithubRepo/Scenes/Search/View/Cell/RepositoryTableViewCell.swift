//
//  RepositoryTableViewCell.swift
//  GithubRepo
//
//  Created by Marcos Alves on 29/09/21.
//

import UIKit
import Kingfisher

class RepositoryTableViewCell: UITableViewCell {
    
    static let kTableViewCellIdentifier = "RepositoryTableViewCell"
    private(set) var repositoryViewModel: RepositoryCellViewModel?
    
    // MARK: - UI Elements
    
    @IBOutlet private weak var ownerLabel: UILabel?
    @IBOutlet private weak var repositoryNameLabel: UILabel?
    @IBOutlet private weak var descriptionLabel: UILabel?
    @IBOutlet private weak var languageLabel: UILabel?
    @IBOutlet private weak var starsLabel: UILabel?
    @IBOutlet private weak var avatarImage: UIImageView?
    @IBOutlet private weak var languageIcon: UIImageView?
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.repositoryViewModel = nil
    }
    
    // MARK: - Setup
    
    private func prepareUI() {
        avatarImage?.layer.cornerRadius = 25
        avatarImage?.layer.borderWidth = 1.0
        avatarImage?.layer.borderColor = UIColor.white.cgColor
    }
    
    // MARK: - Helpers
    
    func setupCell(with repositoryViewModel: RepositoryCellViewModel) {
        self.repositoryViewModel = repositoryViewModel
        let repository = repositoryViewModel.repository
        
        ownerLabel?.text = repository.owner.name
        repositoryNameLabel?.text = repository.name
        descriptionLabel?.text = repository.description
        languageLabel?.text = repository.language
        starsLabel?.text = repository.stars.kmAbbreviation
        languageIcon?.tintColor = repository.language != nil ? UIColor.randomColor: UIColor.black
        
        if let url = repository.owner.avatar {
            avatarImage?.kf.setImage(with: url)
        }
    }
}
