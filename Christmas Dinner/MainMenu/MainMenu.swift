//
//  MainMenu.swift
//  Christmas Dinner
//
//  Created by LUCAS PAJARES PRIETO on 9/1/19.
//  Copyright © 2019 LUCAS PAJARES PRIETO. All rights reserved.
//

import UIKit
import RealmSwift
class MainMenu: UIViewController {

    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var mainMenuTableView: UITableView!
    internal  var repository:ParticipantRepository!
    internal var participants:[Participant] = []
     internal var filteredParticipants: [Participant] = []
    let realm = try! Realm()
    var participant:Participant?
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        participants = repository.getAll()
        mainMenuTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repository = ParticipantRepository()
        participants = repository.getAll()
        configSearchBar()
        registerCell()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showDialog(_ sender: Any) {
        let dialog = Dialog()
       dialog.delegate = self
        dialog.modalTransitionStyle = .coverVertical
        dialog.modalPresentationStyle = .overCurrentContext
        present(dialog, animated:  true, completion:  nil)
    }
    internal func registerCell(){
        let nib = UINib(nibName: "ParticipantCell", bundle: nil)
        mainMenuTableView.register(nib, forCellReuseIdentifier: "ParticipantCell")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    internal func configSearchBar(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search..."
        searchController.searchBar.backgroundColor = UIColor.white
        navigationItem.searchController = searchController
    }
    
    internal func searchBarIsEmpty() -> Bool{
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    internal func isFiltering() -> Bool{
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    internal func filterContentForSearchText(_ searchText: String){
        filteredParticipants = participants.filter({ (nParticipants: Participant ) -> Bool in
            return (nParticipants.name.lowercased().contains(searchText.lowercased()))
        })
        mainMenuTableView.reloadData()
    }
}
extension MainMenu: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return participants.count
    }
    
    
    func numberOfSection(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ParticipantCell = tableView.dequeueReusableCell(withIdentifier: "ParticipantCell", for: indexPath) as! ParticipantCell
        let participant = participants[indexPath.row]
        cell.nameLbl.text = participant.name
        cell.imgCell.isHidden = !participant.isMoroso
        cell.backgroundColor = .clear
        cell.backgroundColor = UIColor(white: 0, alpha: 0.2)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        participants = repository.getAll()
        let participant = participants[indexPath.row]
        participant.isMoroso = !participant.isMoroso
        if repository.update(a: participant){
           mainMenuTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            let participant = participants[indexPath.row]
            if repository.delete(a: participant){
                participants.remove(at: indexPath.row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
            }
        }
    }
    
    /*
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
     return true
     }
     */
    
}
extension MainMenu: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
extension MainMenu: AddDialogDelegate{
    func addViewController(_ vc: Dialog, didEditParticipant participant: Participant) {
        vc.dismiss(animated: true){
            self.participants = self.repository.getAll()
            self.mainMenuTableView.reloadData()
        }
    }
    func errorAddParticipantViewController(_ vc: Dialog) {
        vc.dismiss(animated: true, completion: nil)
        let alert = UIAlertController(title: "ERROR", message: "Name already exists or field is empty", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

