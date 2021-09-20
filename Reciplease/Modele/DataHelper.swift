//
//  DataHelper.swift
//  Reciplease
//
//  Created by Johann Petzold on 17/09/2021.
//

import Foundation

class DataHelper {
    
    // Load data from url on global queue
    func loadDataFromUrl(urlString: String, completion: @escaping (_ data: Data?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                completion(data)
            } else {
                completion(nil)
            }
        }
    }
}
