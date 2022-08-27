//
//  ViewModels.swift
//  CRUD_UI
//
//  Created by PPG on 24.08.22.
//

import Foundation
import SwiftUI

class ViewModel:ObservableObject{
    @Published var items = [PostModel]()
    let prefixUrl = "http://localhost:3000"
    
    init(){
        fetchPots()
    }
    
    
    //Mark: - retrieve data
    func fetchPots(){
        guard let url = URL(string:"\(prefixUrl)/posts") else {
            print("Not found Url")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, res, error) in
            if error != nil {
                print("error", error?.localizedDescription ?? "")
            return
            }
            do {
                if let data = data{
                    let result = try JSONDecoder().decode(DataModel.self, from: data)
                    DispatchQueue.main.async {
                        self.items = result.data
                    }
                }else {
                    print("No data")
                }
            }catch let JsonError{
                print("fetch json error:", JsonError.localizedDescription)
            }

        }.resume()
    }
    
    
    //Mark: - create data
    func createPost(parameters: [String:String]){
        guard let url = URL(string:"\(prefixUrl)/createPost") else {
            print("Not found Url")
            return
        }
        
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, res, error) in
            if error != nil {
                print("error", error?.localizedDescription ?? "")
            return
            }
            do {
                if let data = data{
                    let result = try JSONDecoder().decode(DataModel.self, from: data)
                    DispatchQueue.main.async {
                        print(result)
                    }
                }else {
                    print("No data")
                }
            }catch let JsonError{
                print("fetch json error:", JsonError.localizedDescription)
            }

        }.resume()
    }
    
    //Mark: - update data
    func updatePost(parameters: [String:Any]){
        guard let url = URL(string:"\(prefixUrl)/updatePost") else {
            print("Not found Url")
            return
        }
        
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url:url)
        request.httpMethod = "PUT"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, res, error) in
            if error != nil {
                print("error", error?.localizedDescription ?? "")
            return
            }
            do {
                if let data = data{
                    let result = try JSONDecoder().decode(DataModel.self, from: data)
                    DispatchQueue.main.async {
                        print(result)
                    }
                }else {
                    print("No data")
                }
            }catch let JsonError{
                print("fetch json error:", JsonError.localizedDescription)
            }

        }.resume()
        
    }
        //Mark: - delete data
        func deletePost(parameters: [String:Any]){
            guard let url = URL(string:"\(prefixUrl)/deletePost") else {
                print("Not found Url")
                return
            }
            
            let data = try! JSONSerialization.data(withJSONObject: parameters)
            
            var request = URLRequest(url:url)
            request.httpMethod = "delete"
            request.httpBody = data
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request) { (data, res, error) in
                if error != nil {
                    print("error", error?.localizedDescription ?? "")
                return
                }
                do {
                    if let data = data{
                        let result = try JSONDecoder().decode(DataModel.self, from: data)
                        DispatchQueue.main.async {
                            print(result)
                        }
                    }else {
                        print("No data")
                    }
                }catch let JsonError{
                    print("fetch json error:", JsonError.localizedDescription)
                }

            }.resume()
    }

}
