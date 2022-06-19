//
//  BankDataService.swift
//  iOSDeveloperChallenge
//
//  Created by Muhammed Emin Aydın on 17.06.2022.
//

import Foundation

enum BankDataServiceEndPoint: String {
    case BASE_URL = "https://raw.githubusercontent.com"
    case PATH = "/fatiha380/mockjson/main/bankdata"
    
    static func characterPath() -> String {
        return "\(BASE_URL.rawValue)\(PATH.rawValue)"
    }
}

protocol BankDataServiceProtocol {
    func getBankData(completion: @escaping GetBankDataCompletion)
}

typealias GetBankDataCompletion = (Result<[BankDataModel], Error>) -> Void

class BankDataService: BankDataServiceProtocol {
    
    static let shared = BankDataService()
    
    func getBankData(completion: @escaping GetBankDataCompletion) {
        guard let url = URL(string: "\(BankDataServiceEndPoint.characterPath())") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            do {
                let bankDataModelList = try decoder.decode([BankDataModel].self, from: data)
                completion(.success(bankDataModelList))
                
            } catch let error {
                print(error.localizedDescription)
                completion(.failure(error))
            }
   
        }.resume()
    }
}
