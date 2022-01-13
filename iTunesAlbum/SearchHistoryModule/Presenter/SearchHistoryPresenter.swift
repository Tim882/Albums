//
//  SearchHistoryPresenter.swift
//  iTunesAlbum
//
//  Created by Тимур on 09.11.2021.
//

import Foundation

protocol SearchHistoryViewProtocol: class {
  func showHistoryInfo()
}

protocol SearchHistoryPresenterProtocol {
  var searchHistoryArray: [String] { get set }
  var router: RouterProtocol? { get set }
  init(view: SearchHistoryViewProtocol, router: RouterProtocol)
  func getSearchHistory()
}

class SearchHistoryPresenter: SearchHistoryPresenterProtocol {
  
  var searchHistoryArray: [String] = []
  var view: SearchHistoryViewProtocol?
  var router: RouterProtocol?
  
  required init(view: SearchHistoryViewProtocol, router: RouterProtocol) {
    self.view = view
    self.router = router
    getSearchHistory()
  }
  
  func getSearchHistory() {
    let ns = UserDefaults.standard
    if let arr = ns.array(forKey: "history") as? [String] {
      searchHistoryArray = arr
    }
    else {
      self.view?.showHistoryInfo()
    }
  }
}
