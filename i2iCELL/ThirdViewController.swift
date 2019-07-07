
import UIKit

class ThirdViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.layer.cornerRadius = doneButton.bounds.size.height / 3
        confirmPassword.isSecureTextEntry = true
        newPassword.isSecureTextEntry = true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBOutlet weak var underLine1: UILabel!
    @IBOutlet weak var underlLine2: UILabel!
    @IBOutlet weak var underlLine3: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var RememberIDTC: UITextField!
    @IBOutlet weak var enterName: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        func isValidPassword(testStr:String?) -> Bool {
            guard testStr != nil else { return false }
            let passwordTest = NSPredicate(format: "Özel Karakterler %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
            return passwordTest.evaluate(with: testStr)
        }
        let wsgetSuccess = i2iCellWebService()
        if(newPassword.text! == confirmPassword.text!){
            if(isValidPassword(testStr: newPassword.text)){
                wsgetSuccess.changeUserPassword(userId: enterName.text!, password: newPassword.text!)
                let alert = UIAlertController(title: "Şifre Yenilendi", message: "", preferredStyle: UIAlertController.Style.alert)
                let doneButtonClicked = UIAlertAction(title: "TAMAM", style: UIAlertAction.Style.cancel) { (UIAlertAction) in self.performSegue(withIdentifier: "turnFirst", sender: nil)}
                alert.addAction(doneButtonClicked)
                self.present(alert , animated: true , completion: nil)
            }
            else{
                let alert = UIAlertController(title: "", message: "Şifreniz 8 karakter uzunluğunda olmalı ve en az bir özel karakter ve sayı içermeli", preferredStyle: UIAlertController.Style.alert)
                let doneButtonClicked = UIAlertAction(title: "TAMAM", style: UIAlertAction.Style.cancel, handler: nil )
                alert.addAction(doneButtonClicked)
                self.present(alert , animated: true , completion: nil)
            }
        }
        else if(newPassword.text! != confirmPassword.text!){
            let alert = UIAlertController(title: "", message: "Şifreleriniz eşleşmelidir", preferredStyle: UIAlertController.Style.alert)
            let doneButtonClicked = UIAlertAction(title: "TAMAM", style: UIAlertAction.Style.cancel, handler: nil )
            alert.addAction(doneButtonClicked)
            self.present(alert , animated: true , completion: nil)
        }
    }
}
