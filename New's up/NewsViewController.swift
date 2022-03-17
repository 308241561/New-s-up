//
//  NewsViewController.swift
//  New's up
//
//  Created by hxg on 3/15/22.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var tableView: UITableView!
    
    var news = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
        
        let url = URL(string: "https://newsdata.io/api/1/news?apikey=pub_5505d185c194f5c5e875a66fd65668d7eafd&country=us,cn&language=en,zh&category=politics,technology&page=0")!
        
        /*let url = URL(string: "https://newsdata.io/api/1/news?apikey=pub_5505538662f18408bffd425a1fa646b06dbc&country=us,cn&language=en,zh&category=politics,technology&page=1")!  page = 1 means the second page */
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                 
                 let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 self.news = dataDictionary["results"] as! [[String:Any]]
                 
                 self.tableView.reloadData()
             
                 print(dataDictionary)
                 
                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data

             }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(news.count)
        return news.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        let new = news[indexPath.row]
        let title = new["title"] as! String
        
        cell.textLabel!.text = title
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
