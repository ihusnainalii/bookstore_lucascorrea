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
        
        loadBooks(withSearch: "ios", page: 0)
    }
    
    // MARK: - Private methods
    
    
    private func loadBooks(withSearch search: String, page: Int) {
    
        let maxResult = String(Config.maxResult)
        let page = String(page)
        
        viewModel.bookStoreList(search: search, maxResults: maxResult, startIndex: page, success: { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.isHidden = true
                self?.collectionView.reloadData()
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
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 2, bottom: 5, trailing: 2)
        
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
        
        let viewCellModel = BookViewModel()
        viewCellModel.book = viewModel.bookItems[indexPath.row]
        cell.configure(withViewModel: viewCellModel, indexPath: indexPath)
    
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}
