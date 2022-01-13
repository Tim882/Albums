//
//  ModuleBuilder.swift
//  iTunesAlbum
//
//  Created by Тимур on 09.11.2021.
//

import Foundation
import UIKit

protocol AssemblyModuleBuilderProtocol {
  func createAlbumsListModule(router: RouterProtocol) -> UIViewController
  func createSearchHistoryVC(router: RouterProtocol) -> UIViewController
  func createAlbumsListModuleWithList(name: String, router: RouterProtocol) -> UIViewController
  func createAlbumInfoModule(albumID: String, router: RouterProtocol) -> UIViewController
}

class ModuleBuilder: AssemblyModuleBuilderProtocol {
  
  func createSearchHistoryVC(router: RouterProtocol) -> UIViewController {
    
    let view = SearchHistoryVC()
    let presenter = SearchHistoryPresenter(view: view, router: router)
    
    view.presenter = presenter
    
    return view
  }
  
  func createAlbumsListModule(router: RouterProtocol) -> UIViewController {
    let view = AlbumsListVC()
    let networkService = NetworkService()
    let presenter = AlbumListPresenter(view: view, networkService: networkService, router: router, isAlbumNavigationController: true)
    
    view.presenter = presenter
    
    return view
  }
  
  func createAlbumsListModuleWithList(name: String, router: RouterProtocol) -> UIViewController {
    let view = AlbumsListVC()
    let networkService = NetworkService()
    let presenter = AlbumListPresenter(view: view, networkService: networkService, router: router, isAlbumNavigationController: false)
    
    view.presenter = presenter
    view.presenter.getAlbumsList(albumName: name)
    
    return view
  }
  
  func createAlbumInfoModule(albumID: String, router: RouterProtocol) -> UIViewController {
    let view = AlbumInfoVC()
    let networkService = NetworkService()
    let presenter = AlbumInfoPresenter(albumId: albumID, view: view, networkService: networkService, router: router)
    
    view.presenter = presenter
    view.presenter?.albumId = albumID
    
    return view
  }
}
