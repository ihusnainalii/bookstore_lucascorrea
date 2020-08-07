//
//  Storyboard+Ext.swift
//  BookStore_LucasCorrea
//
//  Created by Lucas Correa on 06/08/2020.
//  Copyright © 2020 SiriusCode. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static func instantiate(identifier: String, creator block: ((NSCoder) -> UIViewController?)? = nil) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(identifier: identifier, creator: block)
    }
}
