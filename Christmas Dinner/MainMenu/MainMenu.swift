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
    override func viewDidLoad() {
        super.viewDidLoad()
        repository = ParticipantRepository()
        participants = repository.getAll()
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MainMenu: AddDialogDelegate{
    func addViewController(_ vc: Dialog, didEditParticipant participant: Participant) {
        vc.dismiss(animated: true){
            self.participants = self.repository.getAll()
            self.mainMenuTableView.reloadData()
        }
    }
}
