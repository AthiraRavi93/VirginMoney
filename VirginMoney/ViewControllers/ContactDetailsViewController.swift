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

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                DispatchQueue.main.async() {
                    self.image =  UIImage(named: "profile-icon")
                }
                
                return
            }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
