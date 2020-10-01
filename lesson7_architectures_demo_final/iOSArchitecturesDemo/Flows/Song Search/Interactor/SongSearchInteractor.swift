//
//  SongSearchInteractor.swift
//  iOSArchitecturesDemo
//
//  Created by Igor Ivanov on 30.09.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import Foundation
import Alamofire

protocol SongSearchInteractorProtocol {
    func requestSongs(with query: String, completion: @escaping (Result<[ITunesSong]>) -> Void)
}


class SongSearchInteractor: SongSearchInteractorProtocol {
    private let searchService = ITunesSearchService()
    private var cache: [ITunesSong] = []
    
    func requestSongs(with query: String, completion: @escaping (Result<[ITunesSong]>) -> Void) {
        
        let songs = cache.filter({$0.trackName == query || $0.artistName == query})
        if !songs.isEmpty {
            let result = Result<[ITunesSong]>.success(songs)
            completion(result)
        }
        
        let outerCompletion:  (Result<[ITunesSong]>) -> Void = { result in
            result.withValue { (songs) in
                if !songs.isEmpty {
                    self.cache.append(contentsOf: songs)
                }
                completion(result)
            }
        }
        searchService.getSongs(forQuery: query, completion: outerCompletion)
    }
}
