//
//  ContactListViewController.swift
//  VirginMoney
//
//  Created by Athira Ravi on 09/10/2022.
//

import UIKit

class ContactListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tbl_Contacts: UITableView!
    var contacts = [Contacts]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contacts"
        downloadJson {
            self.tbl_Contacts.reloadData()
        }
        tbl_Contacts.delegate = self
        tbl_Contacts.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = contacts[indexPath.row].firstName + " " + contacts[indexPath.row].lastName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ContactDetailsViewController {
            destination.contact = contacts[(tbl_Contacts.indexPathForSelectedRow?.row)!]
        }
    }

    func downloadJson(completed: @escaping () -> ()) {
        let url = URL(string: "https:/61e947967bc0550017bc61bf.mockapi.io/api/v1/people")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                    self.contacts = try JSONDecoder().decode([Contacts].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch {
                    print("JSON Error")
                }
            }
        }.resume()
    }
}


