import Foundation



public class AccountInfo: Decodable {
    public var id: String
    public var login: String
    public var money: String
    public var inn: Int
    
    public init() {
        self.id = ""
        self.login = ""
        self.money = ""
        self.inn = 0
    }
    
    public init(id: String, login: String, money: String, inn: Int) {
        self.id = id
        self.login = login
        self.money = money
        self.inn = inn
    }
    
    
    public func updateInfo(completion:@escaping (AccountInfo?) -> () ) {
        guard let jsonUrlString = URL(string: "https://vpsville.ru/api/1.0/account/info") else { return }
        var request = URLRequest(url: jsonUrlString)
        request.httpMethod = "GET"
        request.addValue("application", forHTTPHeaderField: "accept")
        request.addValue(apiKey, forHTTPHeaderField: "vpsville-api-key")
        var json = [AccountInfo()]
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {return}
            do {
                json = try JSONDecoder().decode([AccountInfo].self, from: data)
                self.id = json[0].id
                self.inn = json[0].inn
                self.login = json[0].login
                self.money = json[0].money
                return completion(self)
            }
            catch {
                print ("error with JSONDecoding")
            }
            }.resume()
    }
    
}
