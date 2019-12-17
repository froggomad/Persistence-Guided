//
//  StarsViewController.swift
//  Stars
//
//  Created by Kenny on 12/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class StarsViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var distanceTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func printStarsTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func createStarsTapped(_ sender: UIButton) {
        guard let name = nameTextField.text,
            let distanceString = distanceTextField.text,
            let distance = Double(distanceString) else {return} //TODO: Alert
        
        starController.createStar(with: name, distance: distance)
        tableView.reloadData()
    }
    
    let starController = StarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        // Do any additional setup after loading the view.
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

extension StarsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        starController.stars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StarCell", for: indexPath)
        let star = starController.stars[indexPath.row]
        cell.textLabel?.text = star.name
        cell.detailTextLabel?.text = "\(star.distance)"
        return cell
    }
    
    
}
