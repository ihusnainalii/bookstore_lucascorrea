//
//  UIImageView+Ext.swift
//  BookStore_LucasCorrea
//
//  Created by Lucas Correa on 07/08/2020.
//  Copyright © 2020 SiriusCode. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImage(withUrl url: String) {
        ImageDownload.shared.downloadImageFrom(urlString: url) { (image) in
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
