//
//  ImageCacheService.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/17.
//

import UIKit

final class ImageCacheService {
    static let shared = ImageCacheService()
    private var cache = NSCache<NSString, UIImage>()
    private init() {
        // NSCache의 costLimit 50메가바이트로 초기화
        cache.totalCostLimit = 52428800
    }
    
    func checkMemory(with url: URL) -> UIImage? {
        let key = NSString(string: url.path)
        guard let cachedImage = cache.object(forKey: key) else {
            return nil
        }
        return cachedImage
    }
    
    func saveIntoMemory(_ image: UIImage, with key: String) {
        let key = NSString(string: key)
        cache.setObject(image, forKey: key)
    }
    
    func checkDisk(with imageURL: URL) -> UIImage? {
        guard let filePath = createImagePath(with: imageURL),
              FileManager.default.fileExists(atPath: filePath.path),
              let imageData = try? Data(contentsOf: filePath) else {
            return nil
        }
        let image = UIImage(data: imageData)
        saveIntoMemory(image ?? UIImage(), with: imageURL.path)
        return image
    }
    
    func saveIntoDisk(_ image: UIImage, with imageURL: URL) {
        guard let filePath = createImagePath(with: imageURL) else { return }
        FileManager.default.createFile(
            atPath: filePath.path,
            contents: image.pngData(),
            attributes: nil
        )
    }
    
    private func createImagePath(with imageURL: URL) -> URL? {
        guard let path = FileManager.default.urls(
            for: .cachesDirectory,
            in: .allDomainsMask
        ).first else {
            return nil
        }
        let productImageDirPath = path.appendingPathComponent("productImage")
        let filePath = productImageDirPath.appendingPathComponent(
            imageURL.pathComponents.joined(separator: "-")
        )
        // 폴더 생성 되었는지 확인
        if !FileManager.default.fileExists(atPath: productImageDirPath.path) {
            // 폴더 없으면 폴더 생성
            try? FileManager.default.createDirectory(
                atPath: productImageDirPath.path,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }
        return filePath
    }
}
