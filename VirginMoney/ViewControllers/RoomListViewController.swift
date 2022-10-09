//
//  RoomListViewController.swift
//  VirginMoney
//
//  Created by Athira Ravi on 09/10/2022.
//

import UIKit

class RoomListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tbl_Rooms: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    var rooms = [Room]()
    var filteredList = [Room]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Rooms"
        downloadJson {
            self.segmentControl.selectedSegmentIndex = 0
            self.filterRoomList()
        }
        tbl_Rooms.delegate = self
        tbl_Rooms.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "Room " + filteredList[indexPath.row].id
            
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "showDetails", sender: self)
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as? ContactDetailsViewController {
//            destination.contact = contacts[(tbl_Rooms.indexPathForSelectedRow?.row)!]
//        }
//    }

    func downloadJson(completed: @escaping () -> ()) {
        let url = URL(string: "https:/61e947967bc0550017bc61bf.mockapi.io/api/v1/rooms")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                    let dataString = String(data: data!, encoding: String.Encoding.utf8)
                    print(dataString)
                    self.rooms = try JSONDecoder().decode([Room].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch {
                    print("JSON Error")
                }
            }
        }.resume()
    }
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        filterRoomList()
    }
    
    func filterRoomList(){
        if segmentControl.selectedSegmentIndex == 0{
            filteredList = rooms.filter({ room in
                room.isOccupied == false
            })
        }
        else{
            filteredList = rooms.filter({ room in
                room.isOccupied == true
            })
        }
        tbl_Rooms.reloadData()
    }
}




