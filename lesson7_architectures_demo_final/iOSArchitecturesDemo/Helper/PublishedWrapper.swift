//
//  PublisherType.swift
//  iOSArchitecturesDemo
//
//  Created by Igor Ivanov on 01.10.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import Combine
import Foundation

public class PublishedWrapper<Type> {
    @Published var value: Type?
}

