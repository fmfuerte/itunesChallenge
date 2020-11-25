//
//  ArticleModel.swift
//  News
//
//  Created by Christopher Ching on 2019-10-01.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol TrackModelProtocol {
    
    func tracksRetrieved(_ tracks:[Track])
}

class TrackModel {
    
    var delegate:TrackModelProtocol?
    
    func getTracks(_ searchTerm:String) {
        
        // Create a string URL using a searchTerm
        let stringUrl = "https://itunes.apple.com/search?term="+searchTerm+"&country=au&media=movie&all"
        
         DispatchQueue.main.async {
        // Fire off the request to the API
        AF.request(stringUrl).responseJSON { response in
                switch response.result{
                    
                    case .success(let value):
                        let json = JSON(value)
                       
                        do {
                        // Attempt to parse the JSON
                        let decoder = JSONDecoder()
                    
                        // Parse the json into TrackService
                            let trackService = try decoder.decode(TrackService.self, from: json.rawData())
                       
                        // Get the tracks
                            let results = trackService.results!
                            
                        // Pass it back to the view controller in the main thread
                            UserDefaults.standard.setValue(try json.rawData(), forKey: "savedTracks")
                                
                            self.delegate?.tracksRetrieved(results)
                            
                                          
                        }
                        catch {
                            print("Error parsing the json")
                        } // End Do - Catch
                       
                    
                    case .failure(let error):
                       print(error)
                    }
            }
        
        }
    }
    
}
