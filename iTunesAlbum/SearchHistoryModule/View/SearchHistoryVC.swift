//
//  SearchHistoryVC.swift
//  iTunesAlbum
//
//  Created by Тимур on 09.11.2021.
//

import UIKit

class SearchHistoryVC: UIViewController {
  
  @IBOutlet var searchHistoryTableView: UITableView!
  
  var presenter: SearchHistoryPresenterProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    searchHistoryTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    searchHistoryTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
  }
  
  override func viewWillAppear(_ animated: Bool) {
    presenter.getSearchHistory()
    searchHistoryTableView.reloadData()
  }
}

extension SearchHistoryVC: SearchHistoryViewProtocol {
  func showHistoryInfo() {
    guard let allert = presenter.router?.createAllert(title: "Info", message: "There was no search yet...")
    else {
      return
    }
    self.present(allert, animated: true, completion: nil)
  }
}
