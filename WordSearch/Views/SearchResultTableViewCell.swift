//
//  SearchResultTableViewCell.swift
//  WordSearch
//
//  Created by Maxim Zheleznyy on 8/8/20.
//  Copyright © 2020 Maxim Zheleznyy. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    static let searchResultTableViewCellIdentifier = "SearchResultTableViewCell"
    
    let contentContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .tertiarySystemGroupedBackground
        view.layer.cornerRadius = 5
        return view
    }()
    
    let meaningLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    let meaningPreviewImageView: MeaningImageView = {
        let imageView = MeaningImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let infoTapImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "arrow.right.square")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("Unexpected call to coder-based init")
        super.init(coder: aDecoder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func configureUI() {
        
        contentView.addSubview(contentContainerView)
        contentContainerView.addSubview(meaningPreviewImageView)
        contentContainerView.addSubview(meaningLabel)
        contentContainerView.addSubview(infoTapImageView)
        
        let contentConstraints = [
            contentContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contentContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            contentContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            contentContainerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 66.5),
            
            meaningPreviewImageView.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor, constant: 8),
            meaningPreviewImageView.heightAnchor.constraint(equalToConstant: 50),
            meaningPreviewImageView.widthAnchor.constraint(equalToConstant: 50),
            meaningPreviewImageView.centerYAnchor.constraint(equalTo: contentContainerView.centerYAnchor),
            
            meaningLabel.topAnchor.constraint(equalTo: contentContainerView.topAnchor, constant: 8),
            meaningLabel.leadingAnchor.constraint(equalTo: meaningPreviewImageView.trailingAnchor, constant: 16),
            meaningLabel.bottomAnchor.constraint(equalTo: contentContainerView.bottomAnchor, constant: -8),
            meaningLabel.centerYAnchor.constraint(equalTo: meaningPreviewImageView.centerYAnchor),
            
            infoTapImageView.leadingAnchor.constraint(equalTo: meaningLabel.trailingAnchor, constant: 8),
            infoTapImageView.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor, constant: -8),
            infoTapImageView.widthAnchor.constraint(equalToConstant: 25),
            infoTapImageView.heightAnchor.constraint(equalToConstant: 25),
            infoTapImageView.centerYAnchor.constraint(equalTo: meaningPreviewImageView.centerYAnchor),
        ]
        
        meaningPreviewImageView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        meaningPreviewImageView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        meaningLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        meaningLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        NSLayoutConstraint.activate(contentConstraints)
    }
}
