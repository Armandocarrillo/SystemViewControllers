//
//  ViewController.swift
//  SystemViewController
//
//  Created by Armando Carrillo on 14/07/20.
//  Copyright © 2020 Armando Carrillo. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    
    

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func sharebutton(_ sender: UIButton) {
        guard let image = imageView.image else {return}
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender
        present(activityController, animated: true, completion: nil)
    }
    @IBAction func safariButton(_ sender: UIButton) {
        if let url = URL(string: "http://www.apple.com"){
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func cameraButton(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
               imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
       /*
       let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {action in
        print("User selected camera action")
        })
        alertController.addAction(cameraAction)
        
       let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default, handler: {action in
        print("User selected photo library action")
       })
        
       alertController.addAction(photoLibraryAction)
       */
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            print("User selected camera action")
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {action in imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            print("User selected photo library action")
            let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default, handler: {action in imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
        
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]){
            
            if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                imageView.image = selectedImage
                dismiss(animated: true, completion: nil)
            }
        }
    
        
        alertController.popoverPresentationController?.sourceView = sender
        present(alertController, animated: true, completion: nil)
    }
    @IBAction func emailButton(_ sender: UIButton) {
        print("User selected email action")
        guard MFMailComposeViewController.canSendMail() else {
            print("Can not send mail")
            return
        }
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients(["example@gmail.com"])
        mailComposer.setSubject("Look at this.")
        mailComposer.setMessageBody("Hello, this is an email from the app I made", isHTML: false)
        present(mailComposer, animated: true, completion: nil)
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func textButton(_ sender: UIButton) {
        print("User selected text action")
        guard MFMessageComposeViewController.canSendText() else {
            print ("Can not send text")
            return
        }
        let textComposer = MFMessageComposeViewController()
        textComposer.messageComposeDelegate = self
        textComposer.recipients = ["1234567890"]
        textComposer.body = "Hello baby"
        present(textComposer, animated: true, completion: nil)
        
        
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        dismiss(animated: true, completion: nil)
    }
    
}

