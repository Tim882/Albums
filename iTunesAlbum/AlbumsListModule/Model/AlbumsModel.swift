//
//  AlbumsModel.swift
//  iTunesAlbum
//
//  Created by Тимур on 08.11.2021.
//

import Foundation

struct AlbumsModel: Decodable {
  var resultCount: Int?
  var results: [Album]
}

struct Album: Decodable {
  let artistName: String?
  let collectionPrice: Double?
  let trackName: String?
  let collectionId: Int?
  let artworkUrl100: String?
  let artworkUrl60: String?
  let collectionName: String?
  let releaseDate: String?
  let trackCount: Int?
  let country: String?
  let primaryGenreName: String?
}
