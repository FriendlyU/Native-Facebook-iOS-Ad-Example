//
//  ImageView.swift
//  Native FB Ads Example
//
//  Created by Henry Saniuk on 2/5/17.
//  Copyright © 2017 Henry Saniuk. All rights reserved.
//

import UIKit

extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "Can't get image")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }
}
