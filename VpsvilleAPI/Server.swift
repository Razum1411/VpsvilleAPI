//
//  Price.swift
//  vpsville1.0
//
//  Created by An Zuzu on 27.04.2019.
//  Copyright © 2019 An Zuzu. All rights reserved.
//

import Foundation

struct Disk: Decodable {
    var name: String
    var size: String
    var system: String
}



public class Server: Decodable {
    var id: String
    var ip: String
    var name: String
    var viewname: String?
    var mem: Int
    var cpu: Int
    var status: String
    var os: String
    var disk: [Disk]
    var last_action_time: String
    var created_time: String
    
    
    public init() {
        self.id = ""
        self.ip = ""
        self.name = ""
        self.viewname = ""
        self.mem = 0
        self.cpu = 0
        self.status = ""
        self.os = ""
        self.disk = []
        self.last_action_time = ""
        self.created_time = ""
    }
    
    
    
    public func updateInfo(completion:@escaping ([Server]?) -> () ) {
        guard let jsonUrlString = URL(string: "https://vpsville.ru/api/1.0/servers") else { return }
        var request = URLRequest(url: jsonUrlString)
        request.httpMethod = "GET"
        request.addValue("application", forHTTPHeaderField: "accept")
        request.addValue("52f01bf5f14c930b171223964bc26ef4", forHTTPHeaderField: "vpsville-api-key")
        var json = [Server()]
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {return}
            do {
                json = try JSONDecoder().decode([Server].self, from: data)
                print(json)
                return completion(json)
            }
            catch let jsonErr {
                print ("error with JSONDecoding: \(jsonErr)")
            }
            }.resume()
    }
    
}
