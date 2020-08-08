//
//  BookStoreCollectionViewController.swift
//  BookStore_LucasCorrea
//
//  Created by Lucas Correa on 06/08/2020.
//  Copyright © 2020 SiriusCode. All rights reserved.
//

import UIKit

private let reuseIdentifier = "BookCollectionViewCell"

class BookStoreCollectionViewController: UICollectionViewController {
    
    //
    // MARK: - Oulets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //
    // MARK: - Properties
    var viewModel: BookStoreViewModel
    var currentPage: Int = 0
    
    /// Init
    /// - Parameters:
    ///   - coder: NSCoder
    ///   - viewModel: ViewModel
    init?(coder: NSCoder, viewModel: BookStoreViewModel) {
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
        
        collectionView.collectionViewLayout = createCompositionalLayout()
        collectionView.prefetchDataSource = self
        
        loadBooks(withSearch: Config.query, page: currentPage)
    }
    
    // MARK: - Private methods
    
    private func loadBooks(withSearch search: String, page: Int) {
        
        let maxResult = String(Config.maxResult)
        let page = String(page)
        
        viewModel.bookStoreList(search: search, maxResults: maxResult, startIndex: page, success: { [weak self] indexPaths in
            DispatchQueue.main.async {
                self?.activityIndicator.isHidden = true
                self?.collectionView.insertItems(at: indexPaths)
            }
        }) {  [weak self] error in
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: "Alert", message: error.errorDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { _, layoutEnvironment in
            let isWideView = layoutEnvironment.container.effectiveContentSize.width > 500
            return self.bookLayoutSection(isWide: isWideView)
        }
        return layout
    }
    
    private func bookLayoutSection(isWide: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 2, bottom: 2, trailing: 2)
        
        let groupHeight = NSCollectionLayoutDimension.fractionalWidth(isWide ? 0.25 : 0.5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: groupHeight)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: isWide ? 4 : 2)
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.bookItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BookCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        
        cell.thumbnailImageView.image = #imageLiteral(resourceName: "emptyBook")
        cell.thumbnailImageView.setImage(withUrl: viewModel.bookItems[indexPath.row].thumbnail)
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}


extension BookStoreCollectionViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let needsFetch = indexPaths.contains {$0.row >= viewModel.bookItems.count - 1 }
        if needsFetch {
            currentPage += 1
            loadBooks(withSearch: Config.query, page: currentPage)
        }
    }
}
