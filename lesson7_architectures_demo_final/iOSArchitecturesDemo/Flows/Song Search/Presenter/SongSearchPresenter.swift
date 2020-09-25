//
//  SongSearchPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Igor Ivanov on 25.09.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit


protocol SongSearchViewInput {
    var searchResults: [ITunesSong] { get set }
    func showError(error: Error)
    func showNoResults()
    func hideNoResults()
    func throbber(show: Bool)
}

protocol SongSearchViewOutput {
    func viewDidSearch(with query: String)
    func viewDidSelectSong(_ song: ITunesSong)
}


class SongSearchPresenter {
    
    weak var viewInput: (UIViewController & SongSearchViewInput)?
    private let searchService = ITunesSearchService()
    
    private func requestSongs(with query: String) {
        searchService.getSongs(forQuery: query) { [weak self] result in
            guard let self = self else { return }
            
            self.viewInput?.throbber(show: false)
            result.withValue { (songs) in
                guard !songs.isEmpty else {
                    self.viewInput?.showNoResults()
                    return
                }
                self.viewInput?.hideNoResults()
                self.viewInput?.searchResults = songs
            }.withError {
                self.viewInput?.showError(error: $0)
            }
        }
    }
}

extension SongSearchPresenter: SongSearchViewOutput {
    
    func viewDidSearch(with query: String) {
        viewInput?.throbber(show: true)
        requestSongs(with: query)
    }
    
    func viewDidSelectSong(_ song: ITunesSong) {
    }
}
