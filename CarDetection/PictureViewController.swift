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
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    var takenImage = UIImage()
    
    var carNetResponse: CarNET?
    
    let activityIndicator = UIActivityIndicatorView()
    
    var screenWillShow = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pictureImageView.image = UIImage(named: "gen coupe")
        //pictureImageView.image = takenImage
        
        carNetRequest()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupActivityIndicator()
        
        if screenWillShow == false {
            pictureImageView.isHidden = true
            exitButton.isHidden = true
            labelView.isHidden = true
            activityIndicator.startAnimating()
        }

    }
    
    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        let horizontalConstraint = NSLayoutConstraint(item: activityIndicator, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        view.addConstraint(horizontalConstraint)
        let verticalConstraint = NSLayoutConstraint(item: activityIndicator, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        view.addConstraint(verticalConstraint)
        
        if #available(iOS 13.0, *) {
            activityIndicator.style = .large
        } else {
            activityIndicator.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
            activityIndicator.color = UIColor.black
        }
        
    }
    
    func carNetRequest() {
        
        let headers = [
            "Content-Type": "application/octet-stream",
            "api-key": "9e52c29a-615a-4813-a8c2-421cbb43ace3",
        ]
        let photo = pictureImageView.image?.jpegData(compressionQuality: 0.5)
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
                    self.screenWillShow = true
                    self.activityIndicator.stopAnimating()
                    self.pictureImageView.isHidden = false
                    self.exitButton.isHidden = false
                    self.labelView.isHidden = false
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
                modelLabel.text = make.model_name
                yearLabel.text = make.years
            }
        }
    }

}
