//
//  BookStoreCoordinator.swift
//  BookStore_LucasCorrea
//
//  Created by Lucas Correa on 06/08/2020.
//  Copyright © 2020 SiriusCode. All rights reserved.
//

import UIKit

class BookStoreCoordinator: BaseCoordinator {
    
    //
    // MARK: - Init DI
    
    /// Init
    /// - Parameters:
    ///   - navigationController: UINavigationController
    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
    }
    
    //
    // MARK: - Life cycle
    deinit {
        print("deinit book store coordinator")
    }
    
    //
    // MARK: - Public Functions
    
    /// Start
    override func start() {
        let bookStoreCollectionViewController = UIStoryboard.instantiate(identifier: BookStoreCollectionViewController.className) { coder -> BookStoreCollectionViewController? in
            let bookStoreViewModel = BookStoreViewModel()
            bookStoreViewModel.coordinator = self
            
            // Dependency Injection
            return BookStoreCollectionViewController(coder: coder, viewModel: bookStoreViewModel)
        }
        
        bookStoreCollectionViewController.navigationItem.title = "BookStore"
        self.navigationController.viewControllers = [bookStoreCollectionViewController]
    }

}

//
// MARK: - BookStoreCoordinatorDelegate
extension BookStoreCoordinator: BookStoreCoordinatorDelegate {
    
    func showBookDetail(viewModel: BookDetailViewModel) {
        let coordinator = BookDetailCoordinator(viewModel: viewModel, navigationController: self.navigationController)
        self.start(coordinator: coordinator)
    }
    
}
