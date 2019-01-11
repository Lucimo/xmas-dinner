//
//  Dialog.swift
//  Christmas Dinner
//
//  Created by LUCAS PAJARES PRIETO on 9/1/19.
//  Copyright © 2019 LUCAS PAJARES PRIETO. All rights reserved.
//

import UIKit

protocol AddDialogDelegate : class {
    func addViewController(_ vc: Dialog, didEditParticipant participant: Participant)
     func errorAddParticipantViewController(_ vc:Dialog)
}
class Dialog: UIViewController {

    @IBOutlet weak var dialogName: UITextField!
    @IBOutlet weak var dialogMorosidadSwitch: UISwitch!
    @IBOutlet weak var dialogSendBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
     internal var participant: Participant!
    
    var delegate: AddDialogDelegate?
     internal var repository: ParticipantRepository!
    
    
    convenience init(participant: Participant?){
        self.init()
        if participant == nil {
            self.participant = Participant()
            self.participant.id = UUID().uuidString
            self.participant.name = ""
            self.participant.isMoroso = false
            self.participant.date = Date()
        }
        else{
            self.participant = participant
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func createParticipant(_ sender: Any) {
      
        if(repository.get(name: dialogName.text!) != nil) ||
            (dialogName.text?.elementsEqual(""))!{
            self.delegate?.errorAddParticipantViewController(self)
        }
        else{
            self.dismiss(animated: true)
            participant.name = dialogName.text
            participant.isMoroso = dialogMorosidadSwitch.isOn
            participant.date = Date()
            delegate?.addViewController(self, didEditParticipant: participant)
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
         self.dismiss(animated: true)
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
