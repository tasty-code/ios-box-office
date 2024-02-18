//
//  BundleResourceManager.swift
//  BoxOffice
//
//  Created by Effie on 2/14/24.
//

import Foundation

struct BundleResourceManager {
  private let targetBundle: Bundle
  
  init(target: Bundle = .main) {
    self.targetBundle = target
  }
}

extension BundleResourceManager: FileProvidable {
  func getData(
    from fileName: String,
    extension fileExtension: FileExtension
  ) throws -> Data {
    guard let url = targetBundle.url(
      forResource: fileName,
      withExtension: fileExtension.rawValue
    ) else {
      throw BundleResourceError.notFound
    }
    return try Data(contentsOf: url)
  }
}
