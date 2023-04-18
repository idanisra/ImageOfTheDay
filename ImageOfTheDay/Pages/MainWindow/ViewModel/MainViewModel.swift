//
//  MainViewModel.swift
//  ImageOfTheDay
//
//  Created by Idan Israel on 17/04/2023.
//

import Foundation

class MainViewModel {
    
    // MARK: - Constants
    
    private let RSS_ADDRESS = "https://www.nasa.gov/rss/dyn/lg_image_of_the_day.rss"
    
    // MARK: - Private Variables

    private var rssUrl: URL
    private var rssFetchTimer: Timer?
    private var rssParser = RSSParser()
    
    // MARK: - Events
    
    private var receivedRssItems: [RSSItem]? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let receivedRssItems = self?.receivedRssItems else { return }
                self?.didReceiveRssItems?(receivedRssItems)
            }
        }
    }
    var didReceiveRssItems: (([RSSItem]) -> Void)?
    
    // MARK: - Init
    
    init() {
        
        rssUrl = URL(string: RSS_ADDRESS) ?? URL(fileURLWithPath: "")
    }
    
    deinit {
        
        rssFetchTimer?.invalidate()
    }
        
    // MARK: Private Functions
    
    @objc private func performRssFetchCall() {

        let rssTask = URLSession.shared.dataTask(with: rssUrl) { data, response, error in
            if let data = data {
                self.rssParser.parseRssXml(from: data) { rssItems in
                    self.receivedRssItems = rssItems
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }

        rssTask.resume()
    }
    
    // MARK: - Public Functions

    func startRssFeeder(refreshTime: Double) {
        
        performRssFetchCall()
        rssFetchTimer = Timer.scheduledTimer(timeInterval: refreshTime, target: self, selector: #selector(performRssFetchCall), userInfo: nil, repeats: true)
    }
    
    func stopRssFeeder() {
        
        rssFetchTimer?.invalidate()
    }
}
