//
//  ViewController.swift
//  tldr_content
//
//  Created by Nicholas on 7/25/20.
//  Copyright © 2020 Lux Grey. All rights reserved.
//

import UIKit
import CardSlider

class NewsViewController: UIViewController {
    
    @IBOutlet var newsButton: UIButton!
    
    var newsFeed = NewsFeed()
    var newsData = [NewsData]()
    var data = [ItemModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsFeed.news()
        newsFeed.delegate = self
    }
    
    @IBAction func didTapButton() {
        updateCardUI()
    }

}

extension NewsViewController: CardSliderDataSource {
    
    func updateCardUI() {
        let cardSliderVC = CardSliderViewController.with(dataSource: self)
        cardSliderVC.title = "tl;dr: Tech Content"
        cardSliderVC.modalPresentationStyle = .fullScreen
        present(cardSliderVC, animated: true)
    }
    
    func item(for index: Int) -> CardSliderItem {
        return data[index] as CardSliderItem
    }
    
    func numberOfItems() -> Int {
        return data.count
    }
    
}

extension NewsViewController: NewsFeedDelegate {
    
    func didUpdateNews(news: [NewsData]) {
        let errorURL = URL(string: "https://luxgrey.com/wp-content/uploads/2020/07/app_icon_NH-1.png")
        let errorData = try? Data(contentsOf: errorURL!)
        
        DispatchQueue.main.async {
            var i = 0
            
            while i + 1 < 11 {
                let imageURL = URL(string: news[i].img)
                let imageData = try? Data(contentsOf: imageURL ?? errorURL!)
                let image = UIImage(data: imageData ?? errorData!)
                
                self.data.append(ItemModel(image: image!, rating: nil, title: news[i].title, subtitle: nil, description: news[i].content))
                i += 1
            }
        }
    }
}
