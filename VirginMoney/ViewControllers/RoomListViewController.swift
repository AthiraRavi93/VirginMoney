//
//  RoomListViewController.swift
//  VirginMoney
//
//  Created by Athira Ravi on 09/10/2022.
//

import UIKit

class RoomListViewController: UIViewController {

    @IBOutlet weak var tbl_Rooms: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    var rooms = [Room]()
    var filteredList = [Room]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Rooms"
        NetworkManager.shared.downloadRoomJson(completed: { rooms in
            self.rooms = rooms
            self.segmentControl.selectedSegmentIndex = 0
            self.filterRoomList()
        })
        tbl_Rooms.delegate = self
        tbl_Rooms.dataSource = self

        // Do any additional setup after loading the view.
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

extension RoomListViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "Room " + filteredList[indexPath.row].id
            
        return cell
    }
}



