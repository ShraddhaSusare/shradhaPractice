//
//  ViewController.swift
//  LoginFirst
//
//  Created by Shraddha Susare on 3/23/18.
//  Copyright © 2018 Shraddha Susare. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var phonenoTextField: UITextField!
    @IBOutlet weak var phoneErrorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwdErrLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    var phoneNumber = ""
    var phoneNumInt=0
    var paswd = ""
    var validPhone:Bool = false
    var validPass:Bool = false
    var maxLimit:Int = 9999999999

    override func viewDidLoad() {
        super.viewDidLoad()
        phonenoTextField.becomeFirstResponder()
        loginButton.isEnabled = false
        
        phonenoTextField.delegate = self
        passwordTextField.delegate = self

    }
    //MARK: IBAction method implementation
    @IBAction func actionLogin(_ sender: Any) {
        
        validateLogin()
        if validPhone && validPass {
            print("\(validPhone) and \(validPass)")
            print("Login succeful")
            clearAll()
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "regcon") as! RegistrationViewController
            vc.phoneNumInt = phoneNumInt
            self.present(vc, animated: true, completion: nil)
        }else{
            print("in else")
        }
    }
    
    
    //MARK: Method implementation
    func validateLogin(){
        validPass = false
        validPhone = false
        phoneNumber = phonenoTextField.text!
        print(phoneNumber)
        if phoneNumber.count == 10{
            print("count = 10")
            let check:Int? = Int(phoneNumber)
            if (check != nil){
                print("check not nil i.e only digit")
                phoneNumInt = check!
                //phoneErrorLabel.text=String(phoneNumber)
                validPhone = true
            }
            else{
                phoneErrorLabel.text = "Enter numeric digits not letter"
            }
        }else{
            phoneErrorLabel.text = "Enter 10 digit number"
        }
        
        paswd = passwordTextField.text!
        let pwsTest = NSPredicate(format: "SELF MATCHES %@", "([(0-9)(A-Z)(!@#$%ˆ&*+-=<>)]+)([a-z]*){8,15}")
        let isTrue = pwsTest.evaluate(with: paswd)
        print(isTrue)
        if isTrue == true && paswd.count >= 8{
            validPass = true
        }else{
            
            passwdErrLabel.text = "Pawsd must be alphanumeric"
        }
        
    }
    
    func clearAll() {
        phoneErrorLabel.text = ""
        passwdErrLabel.text = ""
        phonenoTextField.text = ""
        passwordTextField.text = ""
        
    }

    
    //MARK: UITextFieldDelegate methods implementation
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == passwordTextField{
        if string == " "{
            return false
        }
        else{
            return true
        }
        }
        if textField == phonenoTextField{
            if(textField.text!.count < 10)
            {
                let allowedCharacters = CharacterSet.decimalDigits
                let characterSet = CharacterSet(charactersIn: string)
                return allowedCharacters.isSuperset(of: characterSet)
            }
            else{
                //print("gretaer thn 10")
                let  char = string.cString(using: String.Encoding.utf8)!
                let isBackSpace = strcmp(char, "\\b")
                
                if (isBackSpace == -92) {
                    //print("Backspace was pressed")
                    return true
                }
                else{
                return false
                }
            }
    }
        return false

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

        if !(phonenoTextField.text?.isEmpty)! && !(passwordTextField.text?.isEmpty)! {
        loginButton.isEnabled = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }


}

