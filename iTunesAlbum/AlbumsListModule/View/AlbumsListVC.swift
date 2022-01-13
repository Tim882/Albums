//
//  AlbumsListVC.swift
//  iTunesAlbum
//
//  Created by Тимур on 08.11.2021.
//

import UIKit

class AlbumsListVC: UIViewController {
  
  //MARK: - view controller properties
  var searchStr: String?
  var presenter: AlbumListPresenterProtocol!
  
  //MARK: - outlets
  @IBOutlet weak var albumsColletctionView: UICollectionView!
  @IBOutlet weak var albumSearchBar: UISearchBar!
  var notFoundLabel = UILabel()
  var searchActivityIndicator = UIActivityIndicatorView()
  
  let margin: CGFloat = 10
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    albumsColletctionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    guard let flowLayout = albumsColletctionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
    
    flowLayout.minimumInteritemSpacing = margin
    flowLayout.minimumLineSpacing = margin
    flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    
    setInterfaceElements()
  }
  
  //MARK: - set interface elements
  func setInterfaceElements() {
    self.title = "Search album"
    self.tabBarController?.tabBar.items?[0].title = "Search"
    self.tabBarController?.tabBar.items?[0].image = UIImage(systemName: "magnifyingglass")
    self.tabBarController?.tabBar.items?[1].title = "History"
    self.tabBarController?.tabBar.items?[1].image = UIImage(systemName: "book")
    
    albumSearchBar.placeholder = "Enter album name you want to find"
    
    notFoundLabel.text = ""
    notFoundLabel.adjustsFontSizeToFitWidth = true
    notFoundLabel.frame = CGRect(x: 0, y: view.center.y, width: view.bounds.width, height: view.bounds.height / 10)
    notFoundLabel.center = view.center
    notFoundLabel.textAlignment = .center
    notFoundLabel.font = UIFont.boldSystemFont(ofSize: 30)
    notFoundLabel.numberOfLines = 0
    
    searchActivityIndicator.center = view.center
    searchActivityIndicator.hidesWhenStopped = true
    
    view.addSubview(notFoundLabel)
    view.addSubview(searchActivityIndicator)
    
    albumSearchBar.text = searchStr ?? ""
  }
}

extension AlbumsListVC: AlbumListViewProtocol {
  
  func searchDidStart() {
    view.bringSubviewToFront(searchActivityIndicator)
    searchActivityIndicator.startAnimating()
  }
  
  func success() {
    DispatchQueue.main.async {
      self.albumsColletctionView.reloadData()
      if self.presenter.albums?.results.count == 0 {
        self.notFoundLabel.text = "Not found anything by your request:" + "\n"  + "\(self.searchStr ?? "")"
        self.view.bringSubviewToFront(self.notFoundLabel)
      }
      else {
        self.notFoundLabel.text = ""
        self.view.bringSubviewToFront(self.albumsColletctionView)
      }
      self.searchActivityIndicator.stopAnimating()
    }
  }
  
  func failure(error: Error) {
    DispatchQueue.main.async {
      guard let errorAllert = self.presenter.router?.createAllert(title: "Error", message: error.localizedDescription)
      else {
        return
      }
      self.present(errorAllert, animated: true, completion: nil)
      self.searchActivityIndicator.stopAnimating()
    }
  }
  
  
}
