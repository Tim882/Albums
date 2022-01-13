//
//  AlbumInfoPresenter.swift
//  iTunesAlbum
//
//  Created by Тимур on 05.12.2021.
//

import Foundation

protocol AlbumInfoViewProtocol {
  func success()
  func failure(error: Error)
}

protocol AlbumInfoPresenterProtocol {
  var albumId: String { get set }
  var album: AlbumsModel? { get set }
  var router: RouterProtocol? { get set }
  var albumInfo: Album? { get set }
  init(albumId: String, view: AlbumInfoViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
  func getAlbumInfo()
}

class AlbumInfoPresenter: AlbumInfoPresenterProtocol {
  
  var albumInfo: Album?
  var albumId: String
  var networkService: NetworkServiceProtocol!
  var album: AlbumsModel?
  var view: AlbumInfoViewProtocol!
  var router: RouterProtocol?
  
  required init(albumId: String, view: AlbumInfoViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
    self.albumId = albumId
    self.view = view
    self.networkService = networkService
    self.router = router
  }
  
  func getAlbumInfo() {
    networkService.getAlbumsData(type: .info(albumId)) { [weak self] result in
      guard let self = self else {
        return
      }
      
      switch result {
      case .success(let album):
        self.album = album
        if self.album?.results.count ?? 0 > 0 {
          self.albumInfo = self.album?.results[0]
          self.album?.results.remove(at: 0)
        }
        self.view?.success()
      case .failure(let error):
        self.view?.failure(error: error)
      }
    }
  }
  
}
