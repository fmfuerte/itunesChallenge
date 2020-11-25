//
//  ViewController.swift
//  itunesChallenge
//
//  Created by Francis Martin Fuerte on 11/24/20.
//  Copyright © 2020 Fuerte Francis. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, TrackModelProtocol, UITableViewDelegate, UITableViewDataSource {
    
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var asOfLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UITextField!
    
    var model = TrackModel()
    var tracks = [Track]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Set the viewcontroller as the datasource and delegate of the tableview
        tableView.delegate = self
        tableView.dataSource = self
        
        // Get the articles from the article model
        model.delegate = self
        
        // Check if there is saved data
        if let encodedTracks = userDefaults.object(forKey: "savedTracks") as? Data {
            
            // Load the saved track from before
            if let savedTracks = try? JSONDecoder().decode(TrackService.self, from: encodedTracks) {
                self.tracks = savedTracks.results!
            }

            // Update the label to reflect last load of data
            let dateAsOf = userDefaults.string(forKey: "lastLoaded")
            self.asOfLabel.text = "*As of " + dateAsOf!
        
        // Refresh the tableView
        tableView.reloadData()
        }
        else{
            // If no data yet load the default term "star"
            model.getTracks("star")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           
           // Detect the indexpath the user selected
           let indexPath = tableView.indexPathForSelectedRow
           
           guard indexPath != nil else {
               // The user hasn't selected anything
               return
           }
           
           // Get the item the user tapped on
        let trackSelected = self.tracks[indexPath!.row]
           
           // Get a reference to the detail view controller
           let detailVC = segue.destination as! DetailViewController
           
           // Pass the track data to the detail view controller
           detailVC.trackData = trackSelected
       }

    
    func tracksRetrieved(_ tracks: [Track]) {
        
        // Set the track property of the view controller to the tracks passed back from the model
        self.tracks = tracks
        
        // Save the last loaded date to userDefaults
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm"
        userDefaults.set(format.string(from: date), forKey: "lastLoaded")
        
        // Refresh the tableview
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! TrackCell
        
        // Get the track that the tableview is asking about
        let track = tracks[indexPath.row]
        
        // Customize it
        cell.displayTrack(track)
        
        // Return the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // User has just selected a row, trigger the segue to go to detail
        performSegue(withIdentifier: "goToDetail", sender: self)
    }
    
    @IBAction func searchBtnPress(_ sender: Any) {
        // Reload the tableView using a new term from the Search Bar
        if let term = searchBar?.text {
            if term != ""{
                model.getTracks(term)
            }
            else{
                //Load the default term "star" if Search Bar is empty
                model.getTracks("star")
            }
        }
        
    }
    
    


}

