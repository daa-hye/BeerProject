//
//  ViewController.swift
//  BeerProject
//
//  Created by 박다혜 on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet var beerImageView: UIImageView!
    @IBOutlet var beerNameLabel: UILabel!
    @IBOutlet var beerDescription: UILabel!
    @IBOutlet var randomBeerButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        randomBeerButtonDidTap(randomBeerButton)
    }

    @IBAction func randomBeerButtonDidTap(_ sender: UIButton) {

        let url = "https://api.punkapi.com/v2/beers/random"

        AF.request(url, method: .get).validate().responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        print("JSON: \(json)")

                        let name = json[0]["name"].stringValue
                        let description = json[0]["description"].stringValue
                        let imageUrlString = json[0]["image_url"].stringValue
                        let imageUrl = URL(string: imageUrlString)

                        self.beerNameLabel.text = name
                        self.beerDescription.text = description
                        self.beerImageView.kf.setImage(with: imageUrl)

                    case .failure(let error):
                        print(error)
                    }
                }

    }

}

