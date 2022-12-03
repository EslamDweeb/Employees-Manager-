//
//  ImagePicker.swift
//  Leedo
//
//  Created by eslam dweeb on 28/09/2022.
//

import UIKit

public protocol ImageVideoPickerPickerDelegate: AnyObject {
    func didSelect(url: URL?)
    func didSelect(image: UIImage?,path:URL?)
}

open class ImageVideoPicker: NSObject {

    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImageVideoPickerPickerDelegate?

    public init(presentationController: UIViewController, delegate: ImageVideoPickerPickerDelegate) {
        self.pickerController = UIImagePickerController()

        super.init()

        self.presentationController = presentationController
        self.delegate = delegate
    
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.pickerController.mediaTypes = ["public.image","public.movie"]
        self.pickerController.videoQuality = .typeHigh
    }
    
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }
    
    public func present(from sourceView: UIView,addVideo:Bool = true) {

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if let action = self.action(for: .camera, title: "Take Photo") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .savedPhotosAlbum, title: "Camera roll") {
            alertController.addAction(action)
        }
//        if addVideo {
//            if let action = self.action(for: .photoLibrary, title: "Video library") {
//                alertController.addAction(action)
//            }
//        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }

        self.presentationController?.present(alertController, animated: true)
    }
    
    private func videoPickerController(_ controller: UIImagePickerController, didSelect url: URL?) {
        controller.dismiss(animated: true) {
            self.delegate?.didSelect(url: url)
        }
    }
    private func imagePickerController(_ controller: UIImagePickerController, didSelect image: UIImage?,url:URL?) {
        controller.dismiss(animated: true){
            self.delegate?.didSelect(image: image,path: url)
        }
    }
}

extension ImageVideoPicker: UIImagePickerControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.videoPickerController(picker, didSelect: nil)
        self.imagePickerController(picker,didSelect: nil, url: nil)
    }

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        if let url = info[.mediaURL] as? URL  {
            print(url)
            return self.videoPickerController(picker, didSelect: url)
        }
//        if let url = info[.imageURL] as? URL  {
//            print(url)
//            return self.videoPickerController(picker, didSelect: url)
//        }
        if let image = info[.originalImage] as? UIImage  {
//            print(url)
            let path = info[.imageURL] as? URL
            return self.imagePickerController(picker, didSelect: image,url:path)
        }
        if let url = info[.livePhoto] as? URL  {
            print(url)
            return self.videoPickerController(picker, didSelect: url)
        }
        if let image = info[.editedImage] as? UIImage  {
            let path = info[.imageURL] as? URL
            print("image:",image)
            print("path:",image)
            return self.imagePickerController(picker, didSelect: image,url:path)
        }
//        //uncomment this if you want to save the video file to the media library
//        if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path) {
//            UISaveVideoAtPathToSavedPhotosAlbum(url.path, self, nil, nil)
//        }

    }
}

extension ImageVideoPicker: UINavigationControllerDelegate {
    
}
