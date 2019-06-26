//
//  DetailViewController.swift
//  NowPlaying
//
//  Created by Pete Connor on 6/23/19.
//  Copyright © 2019 c0nman. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var posterView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    
    
    var movie: NSDictionary!
    
    override func viewDidLoad() {
        
        //
        titleLabel.text = movie["title"] as? String
        overviewLabel.text = movie["overview"] as? String
        let rating = movie["vote_average"] as? NSNumber
        ratingLabel.text = String(describing: rating!)
        
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        
        if let posterPath = movie["poster_path"] as? String {
            print("string")
            if let imageUrl = URL(string: baseUrl + posterPath) {
                print(imageUrl)
                if let data = try? Data(contentsOf: imageUrl) {
                    print("data!!!")
                    if let image = UIImage(data: data) {
                        print(2)
                        DispatchQueue.main.async {
                            print(3)
                            self.posterView.image = image
                        }
                    }
                }
            }
            
        }
        
    }
}
