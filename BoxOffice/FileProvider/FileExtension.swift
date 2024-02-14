//
//  FileExtension.swift
//  BoxOffice
//
//  Created by Effie on 2/14/24.
//

struct FileExtension: RawRepresentable {
  static let json = Self(rawValue: "json")
  
  let rawValue: String
}
