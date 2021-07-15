//
//  FriendsController.swift
//  Vkontakte
//
//  Created by Lera on 09.07.21.
//

import UIKit

final class FriendsController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var friends: [FriendModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storage = FriendStorage()
        friends = storage.friends
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFriendPhotos" {
            guard let destVC = segue.destination as? FriendPhotosController else { return }
            destVC.friend = sender as? FriendModel
        }
    }
    
}

extension FriendsController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell
        
        cell.friendName?.text = friends[indexPath.row].name
        cell.friendAvatar?.image = friends[indexPath.row].avatar
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friend = friends[indexPath.row]
        performSegue(withIdentifier: "showFriendPhotos", sender: friend)
    }
}
