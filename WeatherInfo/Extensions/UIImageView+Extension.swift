//
//  UIImageView+Extension.swift
//  WeatherInfo
//
//  Created by swapnil.suresh.katwe on 19/03/23.
//

import UIKit
extension UIImageView {
    func loadImage(from urlString: String, with placeholderImage: String? = "iconPlaceHolder") {
        
        guard let url = URL(string: urlString) else {
            loadNoImagePlaceholder(placeholder: placeholderImage ?? "iconPlaceHolder")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let imageData = data,
                  let image = UIImage(data: imageData)
            else {
                self?.loadNoImagePlaceholder(placeholder: placeholderImage ?? "iconPlaceHolder")
                return
            }
            
            DispatchQueue.main.async {
                self?.image = image
            }
        }.resume()
    }
    
    func loadNoImagePlaceholder(placeholder: String) {
        DispatchQueue.main.async {
            self.image = UIImage(named: placeholder)
        }
    }
}
