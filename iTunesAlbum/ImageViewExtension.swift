//
//  ImageViewExtension.swift
//  iTunesAlbum
//
//  Created by Тимур on 08.11.2021.
//

import UIKit

extension UIImageView {
  
  func load(url: URL) {
    
    let loadActivityIndicator = UIActivityIndicatorView()
    loadActivityIndicator.color = UIColor.white
    self.backgroundColor = UIColor.black
    loadActivityIndicator.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
    loadActivityIndicator.autoresizingMask = [.flexibleHeight,
                                              .flexibleWidth,
                                              .flexibleTopMargin,
                                              .flexibleRightMargin,
                                              .flexibleLeftMargin,
                                              .flexibleBottomMargin]
    
    DispatchQueue.main.async {
      self.addSubview(loadActivityIndicator)
    }
    
    loadActivityIndicator.hidesWhenStopped = true
    loadActivityIndicator.startAnimating()
    
    let imageCache = NSCache<NSString, AnyObject>()
    
    if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
      self.image = cachedImage
      return
    }
    
    DispatchQueue.global().async { [weak self] in
      if let data = try? Data(contentsOf: url) {
        if let image = UIImage(data: data) {
          DispatchQueue.main.async {
            self?.contentMode = .center
            self?.image = image
            imageCache.setObject(image, forKey: url.absoluteString as NSString)
            loadActivityIndicator.stopAnimating()
            self?.backgroundColor = .white
          }
        }
      }
    }
  }
}
