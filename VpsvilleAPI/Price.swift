//
//  Price.swift
//  vpsville1.0
//
//  Created by An Zuzu on 27.04.2019.
//  Copyright © 2019 An Zuzu. All rights reserved.
//

import Foundation

struct Vps: Decodable {
    var vps_name: String
    var plan: String
    var type_name: String
    var price: String
    
}

struct License: Decodable {
    var vps_name: String
    var license_name: String
    var license_price: String
    var license_count: String
    var price: String
}

struct Networks: Decodable {
    var vps_name: String
    var net_name: String
    var type: String
    var price: String
}

struct Backups: Decodable {
    var vps_name: String
    var size: String
    var price: String
}

struct Services: Decodable {
    var price: String
    var title: String
}

public class Price: Decodable {
    var vps: [Vps]
    var license: [License]
    var net: [Networks]
    var backup: [Backups]
    var services: [Services]
    var total: Int
    
    public init() {
        self.vps = []
        self.license = []
        self.net = []
        self.backup = []
        self.services = []
        self.total = 0
    }
    
    
    
    public func updateInfo(completion:@escaping (Price?) -> () ) {
        guard let jsonUrlString = URL(string: "https://vpsville.ru/api/1.0/account/price") else { return }
        var request = URLRequest(url: jsonUrlString)
        request.httpMethod = "GET"
        request.addValue("application", forHTTPHeaderField: "accept")
        request.addValue("52f01bf5f14c930b171223964bc26ef4", forHTTPHeaderField: "vpsville-api-key")
        var json = Price()
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {return}
            do {
                json = try JSONDecoder().decode(Price.self, from: data)
                //                self.vps = json.vps
                //                self.license = json.license
                //                self.net = json.net
                //                self.backup = json.backup
                //                self.services = json.services
                //                self.total = json.total
                return completion(json)
            }
            catch let jsonErr {
                print ("error with JSONDecoding: \(jsonErr)")
            }
            }.resume()
    }
    
}
