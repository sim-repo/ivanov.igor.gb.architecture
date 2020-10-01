//
//  SongSearchRouter.swift
//  iOSArchitecturesDemo
//
//  Created by Igor Ivanov on 30.09.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

// #HW8: VIPER

protocol SongSearchRouterInputProtocol {
    func openDetails(for song: ITunesSong)
}


class SongSearchRouterInput: SongSearchRouterInputProtocol {
    weak var viewController: UIViewController?
    
    func openDetails(for song: ITunesSong) {
        let builder: SongDetailBuilder = SongDetailBuilder()
        builder.setSong(song)
        guard let vc = builder.build() else { return }
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openAppInItunes(_ app: ITunesApp) {
        guard let urlString = app.appUrl, let url = URL(string: urlString) else {
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}


