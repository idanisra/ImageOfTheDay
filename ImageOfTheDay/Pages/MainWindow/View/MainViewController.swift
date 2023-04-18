//
//  MainViewController.swift
//  ImageOfTheDay
//
//  Created by Idan Israel on 17/04/2023.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var refreshTextField: UITextField!
    
    @IBOutlet weak var rssTableView: UITableView! {
        didSet {
            rssTableView.layer.cornerRadius = 15.0
            rssTableView.addShadows()
        }
    }
    
    @IBOutlet weak var startButton: UIButton! {
        didSet {
            startButton.layer.cornerRadius = startButton.frame.height / 2
        }
    }
    
    @IBOutlet weak var stopButton: UIButton! {
        didSet {
            stopButton.layer.cornerRadius = stopButton.frame.height / 2
        }
    }
    
    @IBOutlet weak var nasaLogo: UIImageView!
    
    @IBOutlet weak var separatorView: UIView!
    
    // MARK: - Actions
    
    @IBAction func startFeed(_ sender: UIButton) {
        
        if !hasFeedStarted {
            UIView.animate(withDuration: 0.8) {
                self.nasaLogo.isHidden = true
                self.separatorView.isHidden = true
                self.rssTableView.isHidden = false
            }
        }
        
        hasFeedStarted = true
        
        guard let refreshTimeString = refreshTextField.text,
        !refreshTimeString.isEmpty,
        let refreshTime = refreshTimeString.number() else { return }
        
        viewModel.startRssFeeder(refreshTime: refreshTime)
        
        refreshTextField.isEnabled.toggle()
        startButton.isEnabled.toggle()
        stopButton.isEnabled.toggle()
    }
    
    @IBAction func stopFeed(_ sender: UIButton) {
        
        viewModel.stopRssFeeder()
        
        refreshTextField.isEnabled.toggle()
        startButton.isEnabled.toggle()
        stopButton.isEnabled.toggle()
    }
    
    // MARK: - Variables
    
    private var viewModel: MainViewModel = MainViewModel()
    var rssItems = [RSSItem]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.rssTableView.reloadData()
            }
        }
    }
    var hasFeedStarted = false
    
    // MARK: - Init
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        rssTableView.setupTableView(parentVC: self, nibName: RssItemTableViewCell.getReusableIdentifier())
        rssTableView.isScrollEnabled = true
        rssTableView.showsHorizontalScrollIndicator = false
        rssTableView.showsVerticalScrollIndicator = false
        
        viewModel.didReceiveRssItems = { rssItems in
            self.rssItems = rssItems
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rssItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let rssCell = tableView.dequeueReusableCell(withIdentifier: RssItemTableViewCell.getReusableIdentifier()) as? RssItemTableViewCell else {
            return UITableViewCell()
        }
        
        rssCell.addShadows()
        rssCell.selectionStyle = .none
        rssCell.configure(with: rssItems[indexPath.row])
        
        return rssCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let linkOpenerView = LinkOpenerViewController()

        present(linkOpenerView, animated: true)
        linkOpenerView.open(urlAddress: rssItems[indexPath.row].link)
    }
}
