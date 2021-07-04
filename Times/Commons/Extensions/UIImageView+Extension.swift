//
//  UIImageView+Extension.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    
    //MARK: - Public Methods
    
    public func loadArticleImage(_ urlString: String) {
        guard let url: URL = URL(string: urlString) else {
            self.image = UIImage.placeholder
            return
        }
        self.setImage(url, contentMode: UIView.ContentMode.scaleToFill)
    }
    
    
    //MARK: - Private Methods
    
    private func setImage(_ url: URL,
                          placeholder: UIImage? = UIImage.placeholder,
                          contentMode: UIView.ContentMode = UIView.ContentMode.scaleToFill) {
        self.setImage(withURL: url,
                      placeholder: placeholder,
                      contentMode: contentMode,
                      options: [SDWebImageOptions.continueInBackground,
                                SDWebImageOptions.highPriority,
                                SDWebImageOptions.retryFailed,
                                SDWebImageOptions.refreshCached])
    }
    
    private func setImage(withURL url: URL,
                          placeholder: UIImage?,
                          contentMode: UIView.ContentMode = UIView.ContentMode.scaleToFill,
                          options: SDWebImageOptions) {
        self.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
        self.sd_setImage(with: url,
                         placeholderImage: placeholder,
                         options: options) { (image, error, cacheType, url) in
            self.contentMode = image == nil ? UIView.ContentMode.scaleToFill : contentMode
        }
    }
}
