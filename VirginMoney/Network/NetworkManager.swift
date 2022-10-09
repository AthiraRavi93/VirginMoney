//
//  NetworkManager.swift
//  VirginMoney
//
//  Created by Athira Ravi on 10/10/2022.
//

import Foundation
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    public func downloadContactList(completed: @escaping ([Contacts]) -> ()) {
        let url = URL(string: "https:/61e947967bc0550017bc61bf.mockapi.io/api/v1/people")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                    let contacts = try JSONDecoder().decode([Contacts].self, from: data!)
                    DispatchQueue.main.async {
                        completed(contacts)
                    }
                }catch {
                    print("JSON Error")
                }
            }
        }.resume()
    }
    
    func downloadRoomJson(completed: @escaping ([Room]) -> ()) {
        let url = URL(string: "https:/61e947967bc0550017bc61bf.mockapi.io/api/v1/rooms")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                    let rooms = try JSONDecoder().decode([Room].self, from: data!)
                    DispatchQueue.main.async {
                        completed(rooms)
                    }
                }catch {
                    print("JSON Error")
                }
            }
        }.resume()
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

