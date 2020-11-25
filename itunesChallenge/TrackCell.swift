//
//  TrackCell.swift
//  itunesChallenge
//
//  Created by Francis Martin Fuerte on 11/25/20.
//  Copyright © 2020 Fuerte Francis. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class TrackCell: UITableViewCell {
    
    var trackToDisplay:Track?
    @IBOutlet weak var trackImageView: UIImageView!
    
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func displayTrack(_ track:Track) {
        // Clean up the cell before displaying the next article
        trackImageView.image = nil
        
        trackNameLabel.text = ""
        genreLabel.text = ""
        priceLabel.text = ""
        
        // Keep a reference to the track
        trackToDisplay = track
        
        // Set the trackName
        trackNameLabel.text = trackToDisplay!.trackName
        genreLabel.text = trackToDisplay!.primaryGenreName
        
        if let price = trackToDisplay!.trackPrice {
            priceLabel.text = trackToDisplay!.currency! + " " + price.description
        }
        else{
            if let price = trackToDisplay!.collectionPrice {
                priceLabel.text = trackToDisplay!.currency! + " " + price.description
            }
            else {
                priceLabel.text = "N/A"
            }
        
        }
        
        
        // Create url string
        if let artworkUrlString = trackToDisplay!.artworkUrl100 {
        
        // Load Image using url
        let url = URL(string: artworkUrlString)
        self.trackImageView.kf.indicatorType = .activity
        self.trackImageView.kf.setImage(with: url)
            
        }
        else{
            // Load broken asset image if no artwork available
            self.trackImageView.image = UIImage(named: "broken")
        }
    
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
