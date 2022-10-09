//
//  ContactDetailsViewController.swift
//  VirginMoney
//
//  Created by Athira Ravi on 09/10/2022.
//

import UIKit

class ContactDetailsViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_jobTitle: UILabel!
    @IBOutlet weak var lbl_email: UILabel!
    
    var contact:Contacts?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Details"
        img.layer.cornerRadius = img.layer.frame.width/2
        self.navigationController?.navigationBar.prefersLargeTitles = false
        lbl_name.text = (contact?.firstName ?? "") + " " + (contact?.lastName ?? "")
        lbl_jobTitle.text = contact?.jobtitle
        lbl_email.text = contact?.email
        let urlString = (contact?.avatar ?? "")
        let url = URL(string: urlString)
        img.downloadedFrom(url: url!)

    }

}

