//
//  SongDetailBuilfer.swift
//  iOSArchitecturesDemo
//
//  Created by Igor Ivanov on 30.09.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit


// view model ничего не знает об view!
class SongDetailBuilder {
   
    private var song: ITunesSong?
    
    func setSong(_ song: ITunesSong) {
        self.song = song
    }
    
    func build() -> UIViewController? {
        guard let song = song else { return nil }
        let interactor = SongDetailInteractor()
        let router = SongDetailRouterInput()
        
        let viewModel = SongDetailViewModel(song: song, interactor: interactor, router: router)
        let viewController = SongDetailVC(viewModel: viewModel)
        router.viewController = viewController
        return viewController
    }
}

