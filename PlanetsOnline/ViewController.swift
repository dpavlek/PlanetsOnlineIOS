//
//  ViewController.swift
//  PlanetsOnline
//
//  Created by COBE Osijek on 18/07/2017.
//  Copyright © 2017 COBE Osijek. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var planetTable: UITableView!
    
    var stringOfURL = "https://solarsystem.nasa.gov/images/planets/galpic_"
    var planetsStrings = ["mercury", "venus", "earth", "mars", "jupiter", "saturn", "uranus", "neptune"]
    var planets = [Planet]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        planetTable.delegate = self
        planetTable.dataSource = self
        
        DispatchQueue.global().async {
            for name in self.planetsStrings {
                var urlString: String = ""
                urlString += self.stringOfURL + name + ".png"
                if let imageURL = URL(string: urlString) {
                    let data = try? Data(contentsOf: imageURL)
                    self.planets.append(Planet(name: name.capitalized, image: data ?? nil))
                }
                DispatchQueue.main.async {
                    self.planetTable.reloadData()
                }
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "planetCell", for: indexPath) as? PlanetTableViewCell else {
            fatalError("Cell is not PlanetTableViewCell")
        }
        
        cell.planetLabel?.text = planets[indexPath.row].name
        cell.planetImage?.image = UIImage(data: planets[indexPath.row].image!) ?? nil
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
