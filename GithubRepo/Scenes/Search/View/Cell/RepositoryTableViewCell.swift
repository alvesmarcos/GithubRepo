//
//  RepositoryTableViewCell.swift
//  GithubRepo
//
//  Created by Marcos Alves on 29/09/21.
//

import UIKit
import Kingfisher

class RepositoryTableViewCell: UITableViewCell {
    
    private(set) var repositoryViewModel: RepositoryCellViewModel?
    
    // MARK: - UI Elements
    
    @IBOutlet weak var ownerLabel: UILabel?
    @IBOutlet weak var repositoryNameLabel: UILabel?
    @IBOutlet weak var descriptionLabel: UILabel?
    @IBOutlet weak var languageLabel: UILabel?
    @IBOutlet weak var starsLabel: UILabel?
    @IBOutlet weak var avatarImage: UIImageView?
    @IBOutlet weak var languageIcon: UIImageView?
    
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
        
        guard let repository = self.repositoryViewModel?.repository else {
            return
        }
        
        ownerLabel?.text = repository.owner.login
        repositoryNameLabel?.text = repository.name
        descriptionLabel?.text = repository.description
        languageLabel?.text = repository.language
        starsLabel?.text = repository.stars.kmAbbreviation
        languageIcon?.tintColor = repository.language != nil ? UIColor.randomColor: UIColor.black
        
        if let url = URL(string: repository.owner.avatarUrl) {
            avatarImage?.kf.setImage(with: url)
        }
    }
}
