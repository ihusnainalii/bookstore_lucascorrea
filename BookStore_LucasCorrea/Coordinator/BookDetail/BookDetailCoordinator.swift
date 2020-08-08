//
//  BookDetailCoordinator.swift
//  BookStore_LucasCorrea
//
//  Created by Lucas Correa on 08/08/2020.
//  Copyright © 2020 SiriusCode. All rights reserved.
//

import UIKit

class BookDetailCoordinator: BaseCoordinator {
    
    //
    // MARK: - Properties
    var viewModel: BookDetailViewModel
    
    //
    // MARK: - Init DI
    
    /// Init
    /// - Parameters:
    ///   - navigationController: UINavigationController
    init(viewModel: BookDetailViewModel, navigationController: UINavigationController) {
        self.viewModel = viewModel
        super.init(navigationController: navigationController)
    }
    
    //
    // MARK: - Life cycle
    deinit {
        print("deinit search coordinator")
    }
    
    //
    // MARK: - Public Functions
    
    /// Start
    override func start() {
        let bookDetailViewController = UIStoryboard.instantiate(identifier: BookDetailViewController.className) { coder -> BookDetailViewController? in
            return BookDetailViewController(coder: coder, viewModel: self.viewModel)
        }
        
        bookDetailViewController.navigationItem.title = viewModel.book?.title
        self.navigationController.pushViewController(bookDetailViewController, animated: true)
    }

}
