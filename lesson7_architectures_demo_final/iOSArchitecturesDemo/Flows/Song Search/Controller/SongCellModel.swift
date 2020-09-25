//
//  SongSearchCell.swift
//  iOSArchitecturesDemo
//
//  Created by Igor Ivanov on 25.09.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import Foundation

struct SongCellModel {
    let trackName: String
    let artistName: String?
    let collectionName: String?
}

final class SongCellModelFactory {
    static func cellModel(from model: ITunesSong) -> SongCellModel {
        return SongCellModel(trackName: model.trackName,
                             artistName: model.artistName,
                             collectionName: model.collectionName >>- { "\($0)" })
    }
}
