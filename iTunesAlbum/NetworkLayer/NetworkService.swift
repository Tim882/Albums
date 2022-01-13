//
//  NetworkLayer.swift
//  iTunesAlbum
//
//  Created by Тимур on 08.11.2021.
//

import Foundation

protocol NetworkServiceProtocol {
  func getAlbumsData(type: RequestType, complition: @escaping (Result<AlbumsModel?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
  
  //MARK: - request method
  func getAlbumsData(type: RequestType, complition: @escaping (Result<AlbumsModel?, Error>) -> Void) {
    
    var url: URL
    
    switch type {
    case .list(let name):
      let modifiedString = name.replacingOccurrences(of: " ", with: "+")
      
      url = URL(string: "https://itunes.apple.com/search?term=\(modifiedString)&entity=album")!
    case .info(let id):
      url = URL(string: "https://itunes.apple.com/lookup?id=\(id)&entity=song")!
    }
    
    URLSession.shared.dataTask(with: url) { data, _, error in
      if let error = error {
        complition(.failure(error))
        return
      }
            
      do {
        let obj = try JSONDecoder().decode(AlbumsModel.self, from: data!)
        complition(.success(obj))
      } catch {
        complition(.failure(error))
      }
      
    }.resume()
  }
}
