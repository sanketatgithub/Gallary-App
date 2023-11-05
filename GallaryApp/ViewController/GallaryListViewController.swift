//
//  GallaryListViewController.swift
//  GallaryApp
//
//  Created by Sanket Patil on 04/11/23.
//

import UIKit
import Combine

class GallaryListViewController: UIViewController {
    @IBOutlet var gallaryCollectionView: UICollectionView!
    
    var viewModel = GallaryViewModel()
    var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Gallary"
        self.setupCollectionView()
        self.bindErrorMessage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initiateFetchPhotosAPI()
    }
    
    private func setupCollectionView() {
        gallaryCollectionView.collectionViewLayout = getCollectionViewLayout()
    }
    
    private func getCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (self.view.frame.width / 2), height: 250)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        return layout
    }
    
    private func initiateFetchPhotosAPI() {
        Task {
            await self.viewModel.fetchGallaryPhotos()
            self.gallaryCollectionView.reloadData()
        }
    }
}

extension GallaryListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GallaryImageCollectionViewCell.identifier, for: indexPath) as? GallaryImageCollectionViewCell else { return UICollectionViewCell() }
        
        if let photo = self.viewModel.getItem(indexPath: indexPath) {
            cell.configure(photo: photo)
        }
        return cell
    }
}

extension GallaryListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.size.height {
            if !self.viewModel.isLoading {
                self.viewModel.updateOffsetAndLimit()
                self.initiateFetchPhotosAPI()
            }
        }
    }
}

extension GallaryListViewController {
    func bindErrorMessage() {
        self.viewModel.$errorMessage.receive(on: RunLoop.main).sink { message in
            guard let message = message else { return }
            print("Error Message: \(message)")
        }.store(in: &cancellables)
    }
}
