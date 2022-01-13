//
//  CreateAllertFunction.swift
//  iTunesAlbum
//
//  Created by Тимур on 09.11.2021.
//

import Foundation
import UIKit

func showAllert(title: String, message: String) -> UIAlertController {
  let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
  alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
  return alert
}
