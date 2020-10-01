//
//  SongDetailIInteractor.swift
//  iOSArchitecturesDemo
//
//  Created by Igor Ivanov on 30.09.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import Foundation
import Alamofire
import Combine

// #HW8: MVVM
protocol SongDetailIInteractorProtocol {
    func didStartPlay(_ song: ITunesSong)
    func didPause()
    func didStop()
    func didClose()
    
    var onPlaybackCurrentTime: PublishedWrapper<TimeInterval>? { get set }
}


class SongDetailInteractor: SongDetailIInteractorProtocol {
    
    private var timer: Timer?
    private var songDuration: TimeInterval = 0
    private var playbackCurrentTime: TimeInterval = 0
    
    private let searchService = ITunesSearchService()
    
    //output:
    var onPlaybackCurrentTime: PublishedWrapper<TimeInterval>? = PublishedWrapper()
    

    func didStartPlay(_ song: ITunesSong) {
        songDuration = song.trackTimeInSec ?? 0
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.calcPlaybackProgress), userInfo: nil, repeats: true)
    }
    
    func didPause() {
        timer?.invalidate()
    }
    
    func didStop() {
        stop()
    }
    
    func didClose() {
        stop()
    }
    
    @objc private func calcPlaybackProgress() {
        if playbackCurrentTime <= songDuration {
            playbackCurrentTime += 1
            onPlaybackCurrentTime?.value = playbackCurrentTime
        } else {
            stop()
        }
    }
    
    private func stop() {
        timer?.invalidate()
        playbackCurrentTime = 0
    }
}
