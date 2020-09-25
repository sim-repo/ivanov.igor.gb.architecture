//
//  SearchPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Veaceslav Chirita on 9/21/20.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit


protocol SearchViewInput {
    var searchResults: [ITunesApp] {get set}
    func showError(error: Error)
    func showNoResults()
    func hideNoResults()
    func throbber(show: Bool)
}

protocol SearchViewOutput {
    func viewDidSearch(with query: String)
    func viewDidSelectApp(_ app: ITunesApp)
}

class SearchPresenter {
    
    weak var viewInput: (UIViewController & SearchViewInput)?
    
    private let searchService = ITunesSearchService()
    
    private func requestApps(with query: String) {
        searchService.getApps(forQuery: query) { [weak self] result in
            guard let self = self else { return }
            
            self.viewInput?.throbber(show: false)
            result.withValue { (apps) in
                guard !apps.isEmpty else {
                    self.viewInput?.showNoResults()
                    return
                }
                self.viewInput?.hideNoResults()
                self.viewInput?.searchResults = apps
            }.withError {
                self.viewInput?.showError(error: $0)
            }
        }
    }
    
    private func openAppDetails(with app: ITunesApp) {
        let detailPresenter = AppDetailPresenter(app: app)
        let appDetailcVC = AppDetailVC(presenter: detailPresenter, app: app)
        detailPresenter.setup(with: appDetailcVC)
        viewInput?.navigationController?.pushViewController(appDetailcVC, animated: true)
    }
}

extension SearchPresenter: SearchViewOutput {
    func viewDidSearch(with query: String) {
        viewInput?.throbber(show: true)
        requestApps(with: query)
    }
    
    func viewDidSelectApp(_ app: ITunesApp) {
        openAppDetails(with: app)
    }
}
