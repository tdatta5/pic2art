//
//  HomePageViewController.swift
//  Pic2Art
//
//  Created by Tanya Datta on 8/10/22.
//

import UIKit
import Photos
import PhotosUI

class HomePageViewController: UIViewController, PHPickerViewControllerDelegate {
    @IBAction func selectImage(_ sender: Any) {
        presentPicker(filter: PHPickerFilter.images)
        selectionType = .image
    }
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        results.forEach { result in
               result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                   guard let image = reading as? UIImage, error == nil else { return }
                   DispatchQueue.main.async {
                       self.selectedImageOutlet.image = image
                   }
               }
        }
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
        
        let destinationVC = segue.destination as! FinalPageViewController
        destinationVC.image = selectedImageOutlet.image
        
    
    }
    
    @IBOutlet weak var selectedImageOutlet: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    enum SelectionType {
        case image
        case style
    }
    
    var selectionType: SelectionType = .image
    
    /// - Tag: PresentPicker
    private func presentPicker(filter: PHPickerFilter) {
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        
        // Set the filter type according to the user’s selection.
        configuration.filter = filter
        // Set the mode to avoid transcoding, if possible, if your app supports arbitrary image/video encodings.
        configuration.preferredAssetRepresentationMode = .current
        // Set the selection behavior to respect the user’s selection order.
        
        let picker = PHPickerViewController(configuration: configuration)
        
        picker.delegate = self
        present(picker, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear called")
        
    }
    
}

