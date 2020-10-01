//
//  SongDetailVC.swift
//  iOSArchitecturesDemo
//
//  Created by Igor Ivanov on 30.09.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit
import Combine

// #HW8: MVVM
class SongDetailVC: UIViewController {

    var viewModel: (SongDetailVMOutput & SongDetailVMInput)
    private var cancellable = Set<AnyCancellable>()
    
    //MARK:- UI
    lazy var stackView = UIStackView()
    lazy var progressBar = UIProgressView()
    lazy var segmentedControl = UISegmentedControl(items: ["Play", "Pause", "Stop"])
    
    
    
    private(set) lazy var progressLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.numberOfLines = 1
        titleLabel.text = "0:00"
        return titleLabel
    }()
    
    private(set) lazy var artistLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.numberOfLines = 1
        titleLabel.text = ""
        return titleLabel
    }()
    
    private(set) lazy var trackLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: 23)
        titleLabel.numberOfLines = 1
        titleLabel.text = ""
        return titleLabel
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
        configureUI()
    }
    
    init(viewModel: (SongDetailVMOutput & SongDetailVMInput)) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func binding(){
        viewModel.onPlaybackProgressChanged?.$value
            .sink(receiveValue: {[weak self] progress in
                guard let self = self,
                      let progress = progress else { return }
                self.progressBar.setProgress(Float(progress), animated: true)
            })
            .store(in: &cancellable)
        
        viewModel.onPlaybackCurrentTime?.$value
            .sink(receiveValue: {[weak self] progress in
                guard let self = self,
                      let progress = progress else { return }
                self.progressLabel.text = progress
            })
            .store(in: &cancellable)
    }
    
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        navigationItem.largeTitleDisplayMode = .never
        setupStackView()
        setupTrackDescription()
        setupProgressBar()
        setupSegmentControl()
    }
    
    
    private func setupStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4;
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true;
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true;
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true;
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true;
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true;
    }
    
    
    private func setupTrackDescription(){
        trackLabel.text = viewModel.song.trackName
        stackView.addArrangedSubview(trackLabel)
        artistLabel.text = viewModel.song.artistName
        stackView.addArrangedSubview(artistLabel)
        
        NSLayoutConstraint.activate([
            self.trackLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0),
            self.artistLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0)])
    }
    
    private func setupSegmentControl() {
        stackView.addArrangedSubview(segmentedControl)
        segmentedControl.addTarget(self, action: #selector(segmentAction), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 1
    }
    
    
    @objc private func segmentAction() {
        switch (segmentedControl.selectedSegmentIndex) {
               case 0:
                viewModel.onViewDidPressPlay?.value = nil
               case 1:
                   viewModel.onViewDidPressPause?.value  = nil
               case 2:
                   viewModel.onViewDidPressStop?.value  = nil
               default:
                   break
               }
    }
    
    
    private func setupProgressBar() {
        stackView.addArrangedSubview(progressLabel)
        stackView.addArrangedSubview(progressBar)
        progressBar.setProgress(0.0, animated: true)
        progressBar.trackTintColor = .blue
        progressBar.tintColor = .red
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true;
        progressBar.heightAnchor.constraint(equalToConstant: 2).isActive = true;
    }
}
