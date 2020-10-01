//
//  TimeInterval+Extensions.swift
//  iOSArchitecturesDemo
//
//  Created by Igor Ivanov on 01.10.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import Foundation

extension TimeInterval {
    var minuteSecond: String {
        return String(format:"%d:%02d", minute, second)
    }
    
    var minute: Int {
        return Int((self/60).truncatingRemainder(dividingBy: 60))
    }
    var second: Int {
        return Int(truncatingRemainder(dividingBy: 60))
    }
}
