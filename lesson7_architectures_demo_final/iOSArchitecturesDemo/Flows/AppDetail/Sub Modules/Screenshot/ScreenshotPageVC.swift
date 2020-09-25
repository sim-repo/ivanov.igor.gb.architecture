//
//  ScreenshotViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Igor Ivanov on 24.09.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

class ScreenshotPageVC: UIPageViewController {
    
    private let screenshotURLs: [URL]
    private var pageControl = UIPageControl(frame: .zero)
    private let firstSelectedScreenshotNo: Int
    private var timer: Timer?
    
    init(screenshotURLs: [URL], firstSelectedScreenshotNo: Int) {
        self.screenshotURLs = screenshotURLs
        self.firstSelectedScreenshotNo = firstSelectedScreenshotNo
        super.init(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
        dataSource = self
        delegate = self
        restartAction(at: firstSelectedScreenshotNo)
        setupPageControl()
        setupCloseButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        changeOrientation(orientation: .landscapeLeft)
    }
    
    func setupCloseButton() {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitle("✖︎", for: .normal)
        button.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        self.view.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            button.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8),
        ])
    }
    
    @objc func closeButtonAction(sender: UIButton!) {
        changeOrientation(orientation: .portrait)
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.dismis), userInfo: nil, repeats: false)
    }
    
    func changeOrientation(orientation: UIInterfaceOrientation){
        UIDevice.current.setValue(orientation.rawValue, forKey: "orientation")
        UIView.setAnimationsEnabled(true)
    }
    
    @objc func dismis(){
        dismiss(animated: true, completion: nil)
    }
    
    
    func setupPageControl() {
        pageControl.numberOfPages = screenshotURLs.count
        pageControl.currentPage = firstSelectedScreenshotNo
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .orange
        pageControl.pageIndicatorTintColor = .black
        
        let leading = NSLayoutConstraint(item: pageControl, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: pageControl, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: pageControl, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0)
        
        view.insertSubview(pageControl, at: 0)
        view.bringSubviewToFront(pageControl)
        view.addConstraints([leading, trailing, bottom])
    }
    
    
    func restartAction(at index: Int) {
        setViewControllers([createVC(at: index)], direction: .forward, animated: true, completion: nil)
    }
    
    func createVC(at index: Int) -> ScreenshotVC {
        pageControl.currentPage = index
        let url = screenshotURLs[index]
        let vc = ScreenshotVC(screenshotURL: url, pageIndex: index)
        vc.pageIndex = index
        return vc
    }
}

extension ScreenshotPageVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return screenshotURLs.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let beforeVC = viewController as! ScreenshotVC
        var index = beforeVC.pageIndex as Int
        if (index == 0 || index == NSNotFound) {
            return nil
        }
        index -= 1
        
        if 0...screenshotURLs.count - 1  ~= index {
            let vc = createVC(at: index)
            return vc
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let afterVC = viewController as! ScreenshotVC
        var index = afterVC.pageIndex as Int
        if (index == NSNotFound) {
            return nil
        }
        index += 1
        if 0...screenshotURLs.count - 1  ~= index {
            let vc = createVC(at: index)
            return vc
        }
        return nil
    }
}
