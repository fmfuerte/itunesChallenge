//
//  DetailViewController.swift
//  itunesChallenge
//
//  Created by Francis Martin Fuerte on 11/25/20.
//  Copyright © 2020 Fuerte Francis. All rights reserved.
//
import UIKit
import WebKit

class DetailViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextfield: UITextField!
    @IBOutlet weak var genreTextfield: UITextField!
    @IBOutlet weak var priceTextfield: UITextField!
    @IBOutlet weak var longDescTextview: UITextView!
    
    var trackData:Track?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Clear previous data
        imageView.image = nil
        
        titleTextfield.text = ""
        genreTextfield.text = ""
        priceTextfield.text = ""
        longDescTextview.text = ""
        
        // Set the Details
        titleTextfield.text = trackData!.trackName
        genreTextfield.text = trackData!.primaryGenreName
        
        if let price = trackData!.trackPrice {
            priceTextfield.text = trackData!.currency! + " " + price.description
        }
        else{
            if let price = trackData!.collectionPrice {
                priceTextfield.text = trackData!.currency! + " " + price.description
            }
            else {
                priceTextfield.text = "N/A"
            }
        }
        
         if let longDesc = trackData!.longDescription {
                   longDescTextview.text = longDesc
               }
               else{
                   longDescTextview.text = "N/A"
               }
        
        
        if let artworkUrlString = trackData?.artworkUrl100 {
            // Get the base url location of the artwork
            let baseArtworkUrlIndex = artworkUrlString.index(artworkUrlString.endIndex, offsetBy: -14)
            
            // Get the 400x400 version of the artwork
            let biggerArtworkUrl = artworkUrlString[artworkUrlString.startIndex...baseArtworkUrlIndex] + "400x400bb.jpg" as String
            
        // Set the image as the biggerArtwork
        let url = URL(string: biggerArtworkUrl)
        self.imageView.kf.indicatorType = .activity
        self.imageView.kf.setImage(with: url)
            
        }
        
        
    }
    

}

