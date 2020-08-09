//
//  BookDetailViewController.swift
//  BookStore_LucasCorrea
//
//  Created by Lucas Correa on 08/08/2020.
//  Copyright © 2020 SiriusCode. All rights reserved.
//

import UIKit
import SafariServices

class BookDetailViewController: UIViewController {
    
    //
    // MARK: - Oulets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var descriptionTexView: UITextView!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    //
    // MARK: - Properties
    var viewModel: BookDetailViewModel
    
    /// Init
    /// - Parameters:
    ///   - coder: NSCoder
    ///   - viewModel: ViewModel
    init?(coder: NSCoder, viewModel: BookDetailViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillScreen()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.didFinish()
    }
    
    deinit {
        print("deinit book detail view controller")
    }
    
    //
    // MARK: - Private Functions
    private func fillScreen() {
        titleLabel.text = viewModel.book?.title
        authorsLabel.text = viewModel.book?.authors.joined(separator: ", ")
        descriptionTexView.text = viewModel.book?.description
        
        buyButton.isHidden = viewModel.book?.saleability == .notForSale
        favoriteButton.isSelected = viewModel.isFavorite()
    }
    
    //
    // MARK: - Actions
    @IBAction func favoriteAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        viewModel.bookmark(favorite: sender.isSelected)
    }
    
    @IBAction func buyAction(_ sender: Any) {
        if let buyLink = viewModel.book?.buyLink, let url = URL(string: buyLink)  {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        }
    }
    
}
