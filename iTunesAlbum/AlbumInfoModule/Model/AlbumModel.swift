//
//  AlbumModel.swift
//  iTunesAlbum
//
//  Created by Тимур on 05.12.2021.
//

import Foundation

struct AlbumModel: Decodable {
  var resultCount: Int
  var results: [CurrentAlbum]
}

struct CurrentAlbum: Decodable {
  let artistName: String?
  let trackName: String?
  let collectionPrice: Double?
  let collectionId: Int?
  let artworkUrl100: String?
  let artworkUrl60: String?
  let collectionName: String?
  let releaseDate: String?
  let trackCount: Int?
}
