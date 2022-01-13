//
//  AlbumInfoVC.swift
//  iTunesAlbum
//
//  Created by Тимур on 05.12.2021.
//

import UIKit

class AlbumInfoVC: UIViewController {
  
  var presenter: AlbumInfoPresenterProtocol?
  @IBOutlet var albumLabel: UIImageView!
  @IBOutlet var songsTable: UITableView!
  @IBOutlet weak var tracksCountLabel: UILabel!
  @IBOutlet weak var albumPriceLabel: UILabel!
  @IBOutlet weak var albumNameLabel: UILabel!
  @IBOutlet weak var releaseDataLabel: UILabel!
  @IBOutlet weak var countryLabel: UILabel!
  let loadActivityIndicator = UIActivityIndicatorView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    songsTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    
    self.title = "Album"
    
    songsTable.dataSource = self
    
    loadActivityIndicator.hidesWhenStopped = true
    loadActivityIndicator.center = view.center
    view.addSubview(loadActivityIndicator)
    view.bringSubviewToFront(loadActivityIndicator)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    songsTable.separatorStyle = .none
    loadActivityIndicator.startAnimating()
    self.presenter?.getAlbumInfo()
  }
}

extension AlbumInfoVC: AlbumInfoViewProtocol {
  func success() {
    DispatchQueue.main.async {
      self.loadActivityIndicator.stopAnimating()
      self.songsTable.separatorStyle = .singleLine
      self.songsTable.reloadData()
      self.tracksCountLabel.text = "Tracks: \(self.presenter?.album?.results.count ?? 0)"
      self.albumPriceLabel.text = "Price: \(self.presenter?.albumInfo?.collectionPrice ?? 0)$"
      self.albumNameLabel.text = "Name: " + (self.presenter?.albumInfo?.collectionName ?? "")
      self.releaseDataLabel.text = "Release: " + (self.presenter?.albumInfo?.releaseDate ?? "").prefix(10)
      self.countryLabel.text = "Country: " + (self.presenter?.albumInfo?.country ?? "")
    }
    if let artworkUrl = presenter?.albumInfo?.artworkUrl100, let labelURL = URL(string: artworkUrl) {
      albumLabel.load(url: labelURL)
    }
  }
  
  func failure(error: Error) {
    guard let allert = self.presenter?.router?.createAllert(title: "Error", message: error.localizedDescription)
    else {
      return
    }
    self.present(allert, animated: true, completion: nil)
  }
}
