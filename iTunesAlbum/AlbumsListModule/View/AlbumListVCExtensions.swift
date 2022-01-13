//
//  AlbumListVCExtensions.swift
//  iTunesAlbum
//
//  Created by Тимур on 08.11.2021.
//

import Foundation
import UIKit

//MARK: - collection view protocols
extension AlbumsListVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return presenter.albums?.results.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = albumsColletctionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    let urlString = presenter.albums?.results[indexPath.row].artworkUrl100
    guard let url = URL(string: urlString ?? "") else {
      return cell
    }
    
    let imageView = UIImageView(frame: cell.bounds)
    imageView.backgroundColor = UIColor.black
    imageView.load(url: url)
    imageView.layer.cornerRadius = 5
    imageView.layer.masksToBounds = true
    cell.addSubview(imageView)
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let noOfCellsInRow = 2
    let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
    let totalSpace = flowLayout.sectionInset.left
      + flowLayout.sectionInset.right
      + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
    
    let size = Int((albumsColletctionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
    return CGSize(width: size, height: size)
  }
  
  func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
    let itemsInRow: CGFloat = 1
    
    let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
    let finalWidth = (width - totalSpacing) / itemsInRow
    
    return finalWidth - 5.0
  }
}

//MARK: - collection view delegate
extension AlbumsListVC: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    presenter.router?.showAlbumInfo(albumID: String(presenter.albums?.results[indexPath.row].collectionId ?? 0), isAlbumNavigationController: presenter.isAlbumNavigationController)
  }
}

//MARK: - search bar delegate protocol
extension AlbumsListVC: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    albumSearchBar.resignFirstResponder()
    view.bringSubviewToFront(searchActivityIndicator)
    notFoundLabel.text = ""
    presenter.albums?.results = []
    albumsColletctionView.reloadData()
    let ns = UserDefaults.standard
    if var savedArray = ns.array(forKey: "history") as? [String] {
      print(savedArray)
      let savedValue: String = albumSearchBar.text ?? ""
      if savedArray.contains(savedValue) {
        savedArray.remove(at: savedArray.firstIndex(of: savedValue)!)
      }
      savedArray.insert(savedValue, at: 0)
      ns.set(savedArray, forKey: "history")
    }
    else {
      print("else")
      ns.set([], forKey: "history")
    }
    searchStr = albumSearchBar.text
    presenter.getAlbumsList(albumName: albumSearchBar.text ?? "")
  }
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    albumSearchBar.showsCancelButton = true
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    albumSearchBar.text = ""
    albumSearchBar.resignFirstResponder()
    presenter.albums?.results = []
    albumsColletctionView.reloadData()
    albumSearchBar.showsCancelButton = false
  }
}
