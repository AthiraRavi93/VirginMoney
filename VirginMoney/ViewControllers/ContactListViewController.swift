//
//  ContactListViewController.swift
//  VirginMoney
//
//  Created by Athira Ravi on 09/10/2022.
//

import UIKit

class ContactListViewController: UIViewController {

    @IBOutlet weak var tbl_Contacts: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var contacts = [Contacts]()
    var searchList = [Contacts]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contacts"
        NetworkManager.shared.downloadContactList { contactJson in
            self.contacts = contactJson
            self.searchList = contactJson
            self.tbl_Contacts.reloadData()
        }
        tbl_Contacts.delegate = self
        tbl_Contacts.dataSource = self
        searchBar.delegate = self
    }
}

extension ContactListViewController: UITableViewDelegate, UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = searchList[indexPath.row].firstName + " " + searchList[indexPath.row].lastName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ContactDetailsViewController {
            destination.contact = searchList[(tbl_Contacts.indexPathForSelectedRow?.row)!]
        }
    }
}

extension ContactListViewController: UISearchBarDelegate{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.text = ""
        searchList = contacts
        searchBar.endEditing(true)
        tbl_Contacts.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        searchList = searchText.isEmpty ? contacts : contacts.filter
        {
            (item: Contacts) -> Bool in
            let name = item.firstName + " " + item.lastName
            return name.range(of: searchText, options: .caseInsensitive, range: nil,locale: nil) != nil
        }
        tbl_Contacts.reloadData()
    }
}
