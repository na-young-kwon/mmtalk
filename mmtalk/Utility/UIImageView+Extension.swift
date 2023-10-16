//
//  UIImage + Extension.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/17.
//

import UIKit

extension UIImageView {
    func setImage(_ url: String) {
        guard let imageURL = URL(string: url) else {
            return
        }
        // 1. Lookup Memory
        if let image = ImageCacheService.shared.checkMemory(with: imageURL) {
            self.image = image
        }
        
        // 2. Lookup Disk
        if let image = ImageCacheService.shared.checkDisk(with: imageURL) {
            self.image = image
        }
        // 3. Network Request
        URLSession.shared.dataTask(with: imageURL) { (data, result, error) in
            guard error == nil else {
                return
            }
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    self.image = image
                    ImageCacheService.shared.saveIntoMemory(image, with: imageURL.path)
                    ImageCacheService.shared.saveIntoDisk(image, with: imageURL)
                }
            }
        }.resume()
    }
}
