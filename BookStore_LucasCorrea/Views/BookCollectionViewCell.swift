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
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Public Functions
    
    func configure(withViewModel viewModel:BookCellViewModel) {
        titleLabel.text = viewModel.book.title
        thumbnailImageView.image = #imageLiteral(resourceName: "emptyBook")
        thumbnailImageView.setImage(withUrl: viewModel.book.thumbnail)
        thumbnailImageView.isHidden = (viewModel.book.thumbnail.count == 0)
    }
    
}
