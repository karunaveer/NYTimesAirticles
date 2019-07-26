//
//  Extentions.swift
//  NYTimesAirticles
//
//  Created by Karunanithi on 24/07/19.
//  Copyright © 2019 Karunanithi. All rights reserved.
//

import Foundation
import UIKit

public extension UITableViewCell {
    /// Generated cell identifier derived from class name
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}

extension NSLayoutConstraint {
    /// Chainging a layout constraint with priority
    func withPriority(priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}

public extension UIView {
    /// Generating constraints to superview's edge
    func edgeConstraints(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> [NSLayoutConstraint] {
        return [
            self.leftAnchor.constraint(equalTo: self.superview!.leftAnchor, constant: left),
            self.rightAnchor.constraint(equalTo: self.superview!.rightAnchor, constant: -right),
            self.topAnchor.constraint(equalTo: self.superview!.topAnchor, constant: top),
            self.bottomAnchor.constraint(equalTo: self.superview!.bottomAnchor, constant: -bottom)
        ]
    }
}

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func imageFromUrl(_ urlString: String) {
        image = nil
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            image = cachedImage
            return
        }
        if let url = URL(string: urlString) {
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url) { (data, _, _) in
                if let unwrappedData = data, let downloadedImage = UIImage(data: unwrappedData) {
                    DispatchQueue.main.async(execute: {
                        imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                        self.image = downloadedImage
                    })
                }
            }
            dataTask.resume()
        }
    }
}
