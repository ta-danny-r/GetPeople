//
//  ViewController.swift
//  GetPeople
//
//  Created by Danny on 10/16/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var people = [String]()
    let peopleURL: String = "https://swapi.dev/api/people/?format=json"
    var model: DataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPeopleData()
        tableView.dataSource = self
    }
    
    func fetchPeopleData() {
        let url = URL(string: peopleURL)
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: {
            data, response, error in
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    print(jsonResult)
                    
                    if let result = jsonResult["results"] as? NSArray {
                        for person in result {
                            let personDict = person as! NSDictionary
                            let personName = personDict["name"] as! String
                            self.people.append(personName)
                        }
                    }
                }
                self.updateUI()
            } catch {
                print(error)
            }
        })
        task.resume()
        
    }
    
    // Function is used to fetch data from API using Codeable
    func fetchPeopleDataUsingCodeable() {
        let url = URL(string: peopleURL)
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: {
            data, response, error in
            guard let myData = data else { return }
            do {
                let jsonResult = try JSONDecoder().decode(DataModel.self, from: myData)
                self.model = jsonResult
                
                self.updateUI()
            } catch {
                print(error)
            }
        })
        task.resume()
    }
        
    func updateUI() {
        DispatchQueue.main.async {
            print("Aceesing the main UI thread")
            self.tableView.reloadData()
        }
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = people[indexPath.row]
        return cell
    }
}

