//
//  BookCollectionViewCell.swift
//  BookStore_LucasCorrea
//
//  Created by Lucas Correa on 06/08/2020.
//  Copyright © 2020 SiriusCode. All rights reserved.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    //
    // MARK: - Properties
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    //
    // MARK: - Functions
    
    func configure(withViewModel viewModel:BookViewModel, indexPath: IndexPath) {
        let book = viewModel.book
        thumbnailImageView.image = #imageLiteral(resourceName: "emptyBook")
        
        guard let thumbnail = book?.thumbnail else { return }
        self.thumbnailImageView.setImage(withUrl: thumbnail)
    }
}
