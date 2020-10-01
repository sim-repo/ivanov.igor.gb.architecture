//
//  DelimiterView.swift
//  iOSArchitecturesDemo
//
//  Created by Igor Ivanov on 24.09.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit


class DelimiterView: UIView {
 
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    
    private func setupUI() {
        backgroundColor = .lightGray
    }
}
