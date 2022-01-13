//
//  Router.swift
//  iTunesAlbum
//
//  Created by Тимур on 04.01.2022.
//

import UIKit

protocol RouterProtocol {
  var historyNavigationController: UINavigationController? { get set }
  var albumsNavigationController: UINavigationController? { get set }
  var assemblyBuilder: AssemblyModuleBuilderProtocol? { get set }
  func initialViewControllers()
  func showAlbumInfo(albumID: String, isAlbumNavigationController: Bool)
  func showAlbumsList(name: String)
  func createAllert(title: String, message: String) -> UIAlertController
}

class Router: RouterProtocol {
  
  var historyNavigationController: UINavigationController?
  var albumsNavigationController: UINavigationController?
  var assemblyBuilder: AssemblyModuleBuilderProtocol?
  
  init(historyNavigationController: UINavigationController, albumsNavigationController: UINavigationController,
       assemblyBuilder: AssemblyModuleBuilderProtocol) {
    self.historyNavigationController = historyNavigationController
    self.albumsNavigationController = albumsNavigationController
    self.assemblyBuilder = assemblyBuilder
  }
  
  func initialViewControllers() {
    if let historyNavigationController = historyNavigationController {
      guard let historyVC = assemblyBuilder?.createSearchHistoryVC(router: self)
      else {
        return
      }
      historyNavigationController.viewControllers = [historyVC]
    }
    
    if let albumsNavigationController = albumsNavigationController {
      guard let albumsVC = assemblyBuilder?.createAlbumsListModule(router: self)
      else {
        return
      }
      
      albumsNavigationController.viewControllers = [albumsVC]
    }
  }
  
  func showAlbumsList(name: String) {
    if let historyNavigationController = historyNavigationController {
      guard let albumsVC = assemblyBuilder?.createAlbumsListModuleWithList(name: name, router: self) else {
        return
      }
      
      historyNavigationController.pushViewController(albumsVC, animated: true)
    }
  }
  
  func showAlbumInfo(albumID: String, isAlbumNavigationController: Bool) {
    var navigationController: UINavigationController?
    if isAlbumNavigationController {
      navigationController = albumsNavigationController
    }
    else {
      navigationController = historyNavigationController
    }
    
    if let navigationController = navigationController {
      guard let albumInfoVC = assemblyBuilder?.createAlbumInfoModule(albumID: albumID, router: self) else {
        return
      }
      
      navigationController.pushViewController(albumInfoVC, animated: true)
    }
  }
  
  func createAllert(title: String, message: String) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
    return alert
  }
}









