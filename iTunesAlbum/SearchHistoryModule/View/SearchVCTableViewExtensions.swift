//
//  SearchVCTableViewExtensions.swift
//  iTunesAlbum
//
//  Created by Тимур on 09.11.2021.
//

import Foundation
import UIKit

extension SearchHistoryVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    presenter.searchHistoryArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = searchHistoryTableView.dequeueReusableCell(withIdentifier: "Cell") else {
      return UITableViewCell()
    }
    
    cell.textLabel?.text = presenter.searchHistoryArray[indexPath.row]
    cell.textLabel?.textColor = .systemBlue
    
    return cell
  }
  
  
}

extension SearchHistoryVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    presenter.router?.showAlbumsList(name: presenter.searchHistoryArray[indexPath.row])
  }
}
