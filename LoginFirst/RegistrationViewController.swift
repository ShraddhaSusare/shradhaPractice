//
//  RegistrationViewController.swift
//  LoginFirst
//
//  Created by Shraddha Susare on 3/23/18.
//  Copyright © 2018 Shraddha Susare. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController,UITextFieldDelegate{
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameErrLabel: UILabel!
    @IBOutlet weak var phoneTExtFIeld: UITextField!
    @IBOutlet weak var ageStepper: UIStepper!
    @IBOutlet weak var phoneErrLabel: UILabel!
    @IBOutlet weak var gengerSegCOntrol: UISegmentedControl!
    @IBOutlet weak var genderErrLabel: UILabel!
    @IBOutlet weak var ageErrLabel: UILabel!
    @IBOutlet weak var ageViewLabel: UILabel!
    @IBOutlet weak var signoutButton: UIButton!
    
    
    @IBOutlet weak var phoneErrorLabel: UILabel!
    
    let userDefault = UserDefaults.standard

    var name=""
    var phoneNumber=""
    var phoneNumInt:Int=0
    var age:Int=0
    var gender=""
    var valid:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signoutButton.isEnabled = false
        phoneTExtFIeld.text = "\(phoneNumInt)"
        ageViewLabel.text = String(Int(ageStepper.value))
        nameTextField.becomeFirstResponder()
        phoneTExtFIeld.delegate = self
        nameTextField.delegate = self
        print("Name stored:\(userDefault.string(forKey: "name")!)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: IBAction Method implementation
    
    @IBAction func actionStepper(_ sender: Any) {
        age = Int(ageStepper.value)
        ageViewLabel.text = "\(age)"
    }
    
    @IBAction func actionSave(_ sender: Any) {
        validate()
        
        userDefault.set(name, forKey: "name")
        userDefault.set(age, forKey: "age")
        userDefault.set(phoneNumber, forKey: "phoneNumber")
        userDefault.set(gender, forKey: "gender")
        if valid {
            signoutButton.isEnabled = true
            phoneErrorLabel.text = ""
        print("save succesful")
            }else{
            print("Invalid")
            }
    }
    
    @IBAction func actionSignOut(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Methods implementation
    func validate()  {
        valid = true
        
        name = nameTextField.text!
        if name.isEmpty{
            nameErrLabel.text = "name can't be empty"
            print("name empty")
            valid = false
        }
        phoneNumber = phoneTExtFIeld.text!
        if phoneNumber.count == 10{
            print("count = 10")
            let check:Int? = Int(phoneNumber)
            if (check != nil){
                print("check not nil i.e only digit")
                phoneNumInt = check!
                //phoneErrorLabel.text=String(phoneNumber)
                valid = true
            }
            else{
                phoneErrorLabel.text = "Enter numeric digits not letter"
            }
        }else{
            phoneErrorLabel.text = "Enter 10 digit number"
        }
        
        let index = gengerSegCOntrol.selectedSegmentIndex
        if index == 0{
            gender = "Male"
        }else if  index == 1{
            gender = "Female"
        }else{
            gender = "Disclosed"
        }
    }
    

    //MARK: UITextFieldDelegate methods implementation
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == phoneTExtFIeld{
            if(textField.text!.count < 10)
            {
                let allowedCharacters = CharacterSet.decimalDigits
                let characterSet = CharacterSet(charactersIn: string)
                return allowedCharacters.isSuperset(of: characterSet)
            }
            else{
                let  char = string.cString(using: String.Encoding.utf8)!
                let isBackSpace = strcmp(char, "\\b")
                
                if (isBackSpace == -92) {
                    print("Backspace was pressed")
                    return true
                }
                else{
                    return false
                }
            }
        }
        return true
    }

}
