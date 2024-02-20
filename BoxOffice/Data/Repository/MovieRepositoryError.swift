//
//  MovieRepositoryError.swift
//  BoxOffice
//
//  Created by Effie on 2/19/24.
//

enum MovieRepositoryError: Error {
  case urlError
  case decodingError
  case networkServiceError(NetworkServiceError)
  case unknownError
}
