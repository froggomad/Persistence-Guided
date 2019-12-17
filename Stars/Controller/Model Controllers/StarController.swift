//
//  StarController.swift
//  Stars
//
//  Created by Kenny on 12/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

//Model Controller - controls app's interactions with model object. Always a class

class StarController {
    
    //CRUD
    
    //Read
    var stars: [Star] = []
    //use init as ViewDidLoad essentially
    init() {
        loadFromPersistentStore()
    }
    
    //Create
    
    @discardableResult func createStar(with name: String, distance: Double) -> Star {
        let star = Star(name: name, distance: distance)
        stars.append(star)
        saveToPersistentStore()
        return star
    }
    
    //MARK: - Persistence
    
    //save/load Helper
    var persistentFileURL: URL? {
        let fileManager = FileManager.default
        guard let docsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let starsUrl = docsDir.appendingPathComponent("stars.plist")
        return starsUrl
    }
    
    //Save
    
    func saveToPersistentStore() {
        //check to make sure file url exists
        guard let fileURL = persistentFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            
            let starsData = try encoder.encode(stars)
            
            try starsData.write(to: fileURL)
        } catch {
            print("Error Saving stars: \(error)")
        }
    }
    
    
    //Load
    func loadFromPersistentStore() {
        guard let fileURL = persistentFileURL else {return}
        
        do {//step 2 of do/try/catch
            let starsData = try Data(contentsOf: fileURL) //step 1 of do/try/catch
            let decoder = PropertyListDecoder()
            let starsArray = try decoder.decode([Star].self, from: starsData)
            self.stars = starsArray
        } catch {
            //step 3 of do/try/catch
            print("Error loading stars from plist: \(error)")
        }
        
    }
    
    //Update
    
    //Delete
    
}
