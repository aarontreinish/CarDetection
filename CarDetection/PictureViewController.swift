//
//  PictureViewController.swift
//  CarDetection
//
//  Created by Aaron Treinish on 2/25/20.
//  Copyright © 2020 Aaron Treinish. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController {

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var makeLabel: UILabel!
    
    var takenImage = UIImage()
    
    var carNetResponse: CarNET?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        carNetRequest()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        pictureImageView.image = takenImage
        
    }
    
    func carNetRequest() {
        
        let headers = [
            "Content-Type": "application/octet-stream",
            "api-key": "9e52c29a-615a-4813-a8c2-421cbb43ace3",
        ]
        let photo = takenImage.jpegData(compressionQuality: 0.5)
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.carnet.ai/v2/mmg/detect")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = photo
        
        let session = URLSession.shared
        
        session.dataTask(with: request as URLRequest) { (data, response, error) in
            if let error = error {
                print(error)
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode(CarNET.self, from: data)
                
                print(data)
                
                self.carNetResponse = data
                
                DispatchQueue.main.async {
                    self.setLabels()
                }
                
            } catch {
                print(error)
            }
        }.resume()
        
    }
    
    @IBAction func exitButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    func setLabels() {
        for mmg in carNetResponse?.detections ?? [] {
            for make in mmg.mmg ?? [] {
                makeLabel.text = make.make_name
            }
        }
    }

}
