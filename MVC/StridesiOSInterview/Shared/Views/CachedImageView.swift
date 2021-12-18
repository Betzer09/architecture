//
//  CachedImageView.swift
//  StridesiOSInterview
//
//  Created by Austin Betzer on 4/27/21.
//

import Foundation
import UIKit

fileprivate let imageCache = NSCache<AnyObject, AnyObject>()

/**
 An image view that handles downloading and loading cached images.
 */

class CachedImageView: UIImageView {
    
    private var imageURL: URL?
    
    func loadImageWithUrl(_ url: URL, completion: @escaping (Result<UIImage, Error>) -> () ) {

        imageURL = url

        image = nil

        // retrieves image if already available in cache
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        // Load image not already in cache
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            DispatchQueue.main.async {
                guard let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) else { return}
                
                if self.imageURL == url {
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache, forKey: url as AnyObject)
                completion(.success(imageToCache))
            }
        }.resume()
    }

}
