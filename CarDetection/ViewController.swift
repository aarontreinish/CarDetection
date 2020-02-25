//
//  ViewController.swift
//  CarDetection
//
//  Created by Aaron Treinish on 2/24/20.
//  Copyright © 2020 Aaron Treinish. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var takePictureButton: UIButton!
    @IBOutlet weak var tempImageView: UIImageView!
    @IBOutlet weak var exitButton: UIButton!
    
    var captureSession: AVCaptureSession?
    var cameraOutput: AVCapturePhotoOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var takenImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        previewLayer?.frame = cameraView.bounds
        previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupCameraView()
    }
    
    func setupCameraView() {
        
        tempImageView.isHidden = true
        exitButton.isHidden = true
        
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSession.Preset.hd1920x1080
        
        let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera!)
            if captureSession?.canAddInput(input) == true {
                captureSession?.addInput(input)
            }
            
            
            cameraOutput = AVCapturePhotoOutput()
            
            if captureSession?.canAddOutput(cameraOutput ?? AVCapturePhotoOutput()) == true {
                captureSession?.addOutput(cameraOutput ?? AVCapturePhotoOutput())
                
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession ?? AVCaptureSession())
                previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspect
                previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                
                cameraView.layer.addSublayer(previewLayer ?? AVCaptureVideoPreviewLayer())
                captureSession?.startRunning()
                
            }
            
        } catch {
            debugPrint(error)
        }
    }
    
    @IBAction func takePictureButtonAction(_ sender: Any) {
        
        let settings = AVCapturePhotoSettings()
        settings.previewPhotoFormat = settings.embeddedThumbnailPhotoFormat
        
        cameraOutput?.capturePhoto(with: settings, delegate: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pictureTakenSegue" {
            let pictureViewController = segue.destination as? PictureViewController
            
            pictureViewController?.takenImage = takenImage
        }
    }
    
    @IBAction func exitButtonAction(_ sender: Any) {
        
        tempImageView.isHidden = true
        exitButton.isHidden = true
        cameraView.isHidden = false
        takePictureButton.isHidden = false
        
    }
}

extension ViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            debugPrint(error)
        } else {
            
            guard let imageData = photo.fileDataRepresentation() else {
                print("Error while generating image from photo capture data.")
                
                return
            }
            
            guard let image = UIImage(data: imageData) else {
                print("Unable to generate UIImage from image data.")
                
                return
            }
            
            takenImage = image
            
            performSegue(withIdentifier: "pictureTakenSegue", sender: self)
            
            
            //self.tempImageView.image = image
            
//            if let savedImage = tempImageView.image {
//                if let data = savedImage.pngData() {
//
//                    let filename = getDocumentsDirectory().appendingPathComponent("car-image.png")
//                    try? data.write(to: filename)
//                }
//            }
            
            //tempImageView.isHidden = false
            //exitButton.isHidden = false
            //cameraView.isHidden = true
            //takePictureButton.isHidden = true
            
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}
