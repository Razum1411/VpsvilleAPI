//
//  Price.swift
//  vpsville1.0
//
//  Created by An Zuzu on 27.04.2019.
//  Copyright © 2019 An Zuzu. All rights reserved.
//

import Foundation



public class Plans: Decodable {
    var name: String
    var cpu: String
    var memory: String
    var disk: String
    var os: String
    var money: String


    public init() {
        self.name = ""
        self.cpu = ""
        self.memory = ""
        self.disk = ""
        self.os = ""
        self.money = ""
    }



    public func updateInfo(completion:@escaping ([Plans]?) -> () ) {
        guard let jsonUrlString = URL(string: "https://vpsville.ru/api/1.0/configuration/plans") else { return }
        var request = URLRequest(url: jsonUrlString)
        request.httpMethod = "GET"
        request.addValue("application", forHTTPHeaderField: "accept")
        request.addValue("52f01bf5f14c930b171223964bc26ef4", forHTTPHeaderField: "vpsville-api-key")
        var json = [Plans()]
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {return}
            do {
                json = try JSONDecoder().decode([Plans].self, from: data)
                print(json)
                //                for i in 0..<json.count {
                //                self.id = json[i].id
                //                self.ip = json[i].ip
                //                self.name = json[i].name
                //                self.viewname = json[i].viewname
                //                self.mem = json[i].mem
                //                self.cpu = json[i].cpu
                //                self.status = json[i].status
                //                self.os = json[i].os
                //                self.disk = json[i].disk
                //                self.last_action_time = json[i].last_action_time
                //                self.created_time = json[i].created_time
                //                }
                return completion(json)
            }
            catch let jsonErr {
                print ("error with JSONDecoding: \(jsonErr)")
            }
            }.resume()
    }

}
