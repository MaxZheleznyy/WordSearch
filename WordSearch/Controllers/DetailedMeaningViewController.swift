//
//  DetailedMeaningViewController.swift
//  WordSearch
//
//  Created by Maxim Zheleznyy on 8/8/20.
//  Copyright © 2020 Maxim Zheleznyy. All rights reserved.
//

import UIKit

class DetailedMeaningViewController: UIViewController {
    
    //MARK: - UI
    let meaningImageView: MeaningImageView = {
        let imageView = MeaningImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let searchAndTranslateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    let searchTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    let translationTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    let fromToImageViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    let fromToArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "arrow.left.and.right.circle.fill")
        return imageView
    }()
    
    let bottomPlaceholderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    //MARK: - Constraints
    let searchWord: String
    let meaning: Meaning
    
    //MARK: - Lifecycle
    init(searchWord: String, meaning: Meaning) {
        self.searchWord = searchWord
        self.meaning = meaning
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMainView()
        addContentUI()
        fillUpUIWithData()
    }
    
    //MARK: - Actions
    func configureMainView() {
        view.backgroundColor = .systemBackground
        
        let imageIcon = UIImage(systemName: "xmark.circle.fill")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        let barButton = UIBarButtonItem(image: imageIcon, style: .done, target: self, action: #selector(closeViewTapped))
        navigationItem.rightBarButtonItem = barButton
    }
    
    func addContentUI() {
        view.addSubview(meaningImageView)
        view.addSubview(searchAndTranslateStackView)
        view.addSubview(bottomPlaceholderView)
        
        fromToImageViewContainer.addSubview(fromToArrowImageView)
        
        searchAndTranslateStackView.addArrangedSubview(searchTextLabel)
        searchAndTranslateStackView.addArrangedSubview(fromToImageViewContainer)
        searchAndTranslateStackView.addArrangedSubview(translationTextLabel)
        
        let contentConstraints = [
            meaningImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            meaningImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            meaningImageView.heightAnchor.constraint(equalToConstant: 200),
            meaningImageView.widthAnchor.constraint(equalToConstant: 200),
            
            searchAndTranslateStackView.topAnchor.constraint(equalTo: meaningImageView.bottomAnchor, constant: 24),
            searchAndTranslateStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchAndTranslateStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            bottomPlaceholderView.topAnchor.constraint(equalTo: searchAndTranslateStackView.bottomAnchor),
            bottomPlaceholderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomPlaceholderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomPlaceholderView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            
            fromToArrowImageView.widthAnchor.constraint(equalToConstant: 25),
            fromToArrowImageView.heightAnchor.constraint(equalToConstant: 25),
            fromToArrowImageView.centerYAnchor.constraint(equalTo: fromToImageViewContainer.centerYAnchor),
            fromToArrowImageView.centerXAnchor.constraint(equalTo: fromToImageViewContainer.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(contentConstraints)
    }
    
    func fillUpUIWithData() {
        searchTextLabel.text = searchWord
        translationTextLabel.text = meaning.translation?.text
        
        if let imageURL = meaning.fixedImageURL {
            meaningImageView.loadImageFromURL(url: imageURL)
        }
    }
    
    @objc func closeViewTapped() {
        dismiss(animated: true, completion: nil)
    }
}
