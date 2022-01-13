//
//  AlbumsPresenter.swift
//  iTunesAlbum
//
//  Created by Тимур on 08.11.2021.
//

import Foundation

protocol StartSearchIndicatorDelegate {
  func searchDidStart()
}

protocol AlbumListViewProtocol: class, StartSearchIndicatorDelegate {
  var searchStr: String? { get set }
  func success()
  func failure(error: Error)
}

protocol AlbumListPresenterProtocol: class {
  init(view: AlbumListViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, isAlbumNavigationController: Bool)
  var albums: AlbumsModel? { get set }
  var router: RouterProtocol? { get set }
  var isAlbumNavigationController: Bool { get set }
  func getAlbumsList(albumName: String)
}

class AlbumListPresenter: AlbumListPresenterProtocol {
  
  var view: AlbumListViewProtocol?
  var networkService: NetworkServiceProtocol!
  var albums: AlbumsModel?
  var router: RouterProtocol?
  var isAlbumNavigationController: Bool
  
  required init(view: AlbumListViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, isAlbumNavigationController: Bool) {
    self.view = view
    self.networkService = networkService
    self.router = router
    self.isAlbumNavigationController = isAlbumNavigationController
  }
  
  func getAlbumsList(albumName: String) {
    
    view?.searchDidStart()
    view?.searchStr = albumName
    
    networkService.getAlbumsData(type: .list(albumName)) { [weak self] result in
      guard let self = self else {
        return
      }
      
      switch result {
      case .success(let albums):
        self.albums = albums
        self.view?.success()
      case .failure(let error):
        self.view?.failure(error: error)
      }
    }
  }
}
