//
//  MoviesTableViewController.swift
//  NowPlaying
//
//  Created by Pete Connor on 6/17/19.
//  Copyright © 2019 c0nman. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {
    
    var movies: [NSDictionary]?
    var endpoint: String!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let apiKey = "dd1fed7eede948d0697c67af77a4e3af"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = URLRequest(url: url! as URL)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task: URLSessionDataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if let data = data {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
                    NSLog("response: \(responseDictionary)")
                    print("response: \(responseDictionary)")
                    
                    self.movies = responseDictionary["results"] as? [NSDictionary]
                    self.tableView.reloadData()
                }
            }
        });
        
        task.resume()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = movies {
            return movies.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let movie = movies![indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        let rating = movie["vote_average"] as! NSNumber
        
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
                        cell.posterView.image = image
                    }
                    }
                }
            }
            
        }
        
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        cell.ratingLabel.text = String(describing: rating)
        print("rating: \(rating)")
        print(type(of: rating))
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        let movie = movies![indexPath!.row]
        
        
        
        let destinationVC = segue.destination as! DetailViewController
        destinationVC.movie = movie
    }

   
}
