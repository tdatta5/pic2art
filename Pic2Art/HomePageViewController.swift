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
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        results.forEach { result in
               result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                   guard let image = reading as? UIImage, error == nil else { return }
                   DispatchQueue.main.async {
                       if self.selectionType == .image {
                           self.selectedImageOutlet.image = image
                       } else {
                           self.selectedStyleOutlet.image = image
                       }
                   }
               }
        }
    }
        
    
    @IBOutlet weak var selectedImageOutlet: UIImageView!
    @IBOutlet weak var selectedStyleOutlet: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func presentPickerForImages(_ sender: Any) {
        presentPicker(filter: PHPickerFilter.images)
        selectionType = .image
    }
    
    @IBAction func presentPickerForStyle(_ sender: Any) {
        presentPicker(filter: PHPickerFilter.images)
        selectionType = .style
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

