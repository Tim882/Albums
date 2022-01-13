//
//  AlbumInfoVCExtensions.swift
//  iTunesAlbum
//
//  Created by Тимур on 07.12.2021.
//

import UIKit

extension AlbumInfoVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter?.album?.results.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = songsTable.dequeueReusableCell(withIdentifier: "Cell") else {
      return UITableViewCell()
    }
    
    cell.textLabel?.adjustsFontSizeToFitWidth  = true
    cell.textLabel?.numberOfLines = 0
    
    cell.textLabel?.text = (presenter?.album?.results[indexPath.row].artistName ?? "") + "\n" + (presenter?.album?.results[indexPath.row].trackName ?? "")
    
    return cell
  }
}

//MARK: - table view delegate
extension AlbumInfoVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}
