//
//  MeaningImageView.swift
//  WordSearch
//
//  Created by Maxim Zheleznyy on 8/8/20.
//  Copyright © 2020 Maxim Zheleznyy. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class MeaningImageView: UIImageView {
    
    let activityIndicator: UIActivityIndicatorView = {
        let aI = UIActivityIndicatorView(style: .medium)
        aI.translatesAutoresizingMaskIntoConstraints = false
        aI.hidesWhenStopped = true
        return aI
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(activityIndicator)
        
        let contentConstraints = [
            activityIndicator.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor),
            activityIndicator.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor),
            activityIndicator.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor),
            activityIndicator.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(contentConstraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadImageFromURL(url: String) {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.startAnimating()
        self.image = nil
        let possibleErrorPlaceholder = UIImage(systemName: "xmark.octagon")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        
        guard let URL = URL(string: url) else {
            print("Can't find an image for the url", url)
            stopSpinnerAndSetImage(possibleErrorPlaceholder)
            return
        }
        
        if let cachedImage = imageCache.object(forKey: url as AnyObject) as? UIImage {
            stopSpinnerAndSetImage(cachedImage)
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: URL) {
                if let image = UIImage(data: data) {
                    let imageTocache = image
                    imageCache.setObject(imageTocache, forKey: url as AnyObject)
                    
                    DispatchQueue.main.async {
                        self?.stopSpinnerAndSetImage(imageTocache)
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.stopSpinnerAndSetImage(possibleErrorPlaceholder)
                    }
                }
            }
        }
    }
    
    private func stopSpinnerAndSetImage(_ imageToSet: UIImage?) {
        activityIndicator.stopAnimating()
        image = imageToSet
    }
}
