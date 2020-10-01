//
//  SongDetailPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Igor Ivanov on 30.09.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit
import Combine

protocol SongDetailVMInput {
    var onViewDidPressPlay: PublishedWrapper<Any>? { get set }
    var onViewDidPressPause: PublishedWrapper<Any>? { get set }
    var onViewDidPressStop: PublishedWrapper<Any>? { get set }
}


protocol SongDetailVMOutput {
    var song: ITunesSong { get }
    var onStartPlay: PublishedWrapper<Any>? { get set }
    var onPlaybackProgressChanged: PublishedWrapper<Double>? { get set }
    var onPlaybackCurrentTime: PublishedWrapper<String>? { get set }
}
 

final class SongDetailViewModel: SongDetailVMInput, SongDetailVMOutput {
    
    let interactor: SongDetailIInteractorProtocol
    let router: SongDetailRouterInputProtocol
    
    //input:
    var onViewDidPressPlay: PublishedWrapper<Any>? = PublishedWrapper()
    var onViewDidPressPause: PublishedWrapper<Any>? = PublishedWrapper()
    var onViewDidPressStop: PublishedWrapper<Any>? = PublishedWrapper()
    
    //output:
    private (set) var song: ITunesSong
    var onStartPlay: PublishedWrapper<Any>? = PublishedWrapper()
    var onPlaybackProgressChanged: PublishedWrapper<Double>? = PublishedWrapper()
    var onPlaybackCurrentTime: PublishedWrapper<String>? = PublishedWrapper()
    
    
    private var cancellable = Set<AnyCancellable>()
    
    
    init(song: ITunesSong, interactor: SongDetailIInteractorProtocol, router: SongDetailRouterInputProtocol ) {
        self.song = song
        self.interactor = interactor
        self.router = router
        binding()
    }
    
    
    private func binding(){
        
        interactor.onPlaybackCurrentTime?.$value
            .dropFirst()
            .sink(receiveValue: {[weak self] currentTime in
                guard let self = self,
                      let trackTimeInSec = self.song.trackTimeInSec,
                      let currentTime = currentTime
                      else { return }
                let inPercent: Double = currentTime/trackTimeInSec
                self.onPlaybackCurrentTime?.value = currentTime.minuteSecond
                self.onPlaybackProgressChanged?.value = inPercent
            })
            .store(in: &cancellable)
        
        
        onViewDidPressPlay?.$value
            .dropFirst()
            .sink(receiveValue: {[weak self] progress in
                guard let self = self else { return }
                self.interactor.didStartPlay(self.song)
            })
            .store(in: &cancellable)
        
        
        onViewDidPressPause?.$value
            .dropFirst()
            .sink(receiveValue: {[weak self] progress in
                guard let self = self else { return }
                self.interactor.didPause()
            })
            .store(in: &cancellable)
        
        
        onViewDidPressStop?.$value
            .dropFirst()
            .sink(receiveValue: {[weak self] progress in
                guard let self = self else { return }
                self.interactor.didStop()
            })
            .store(in: &cancellable)
    }
}

