//
//  APIClint.swift
//  OnTheMap
//
//  Created by nF ™ on 12/07/2020.
//  Copyright © 2020 nF ™. All rights reserved.
//

import Foundation

enum EndPoints {
    case StudentsLocations
    case Session
    var StringValue : String {
        switch self {
        case .StudentsLocations:
            return "https://onthemap-api.udacity.com/v1/StudentLocation"
        case .Session:
            return "https://onthemap-api.udacity.com/v1/session"
        }
    }
    var url :URL {
        return URL(string: self.StringValue)!
    }
}

class APIClient {
    
    class func getStudentLocations(completion:@escaping (StudentLocationModel?,Error?) -> Void) {
        taskforGETRequest(url: EndPoints.StudentsLocations.url, responseType: StudentLocationModel.self) { (data, error) in
            guard let data = data else {
                completion(nil,error)
                return
            }
            completion(data,nil)
        }
    }
    class func postStudentLocations(Student:PostRequest, completion: @escaping (PostResponse?,Error?) -> Void) {
        taskforPOSTRequest(url: EndPoints.StudentsLocations.url, responseType: PostResponse.self, body: Student) { (response, error) in
            guard let response = response else {
                completion(nil,error)
                return
            }
            completion(response, nil)
        }
    }
    class func createSession(UserInfo:CreateSession, completion: @escaping (String?,Error?) -> Void) {
        taskforPOSTSesstion(body: UserInfo) { (data, error) in
            guard let data = data else {
                completion(nil,error)
                return
            }
            completion(data,nil)
        }
    }
    
    class func logOut() {
        taskforDELETERequest(responseType: CreateSession.self) { (response, error) in
            
        }
    }
    class func taskforGETRequest<ResponseType:Decodable>(url:URL,responseType:ResponseType.Type,completion:@escaping (ResponseType?,Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(nil,error)
                return
            }
            do {
                let reponseObject = try JSONDecoder().decode(responseType.self, from: data)
             //   print(String(data: data, encoding: .utf8) ?? "")
                completion(reponseObject,nil)
            } catch {
                completion(nil,error)
            }
        }
        task.resume()
    }
    class func taskforPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            guard let data = data else {
                return
            }
            do {
                let decode = try JSONDecoder().decode(ResponseType.self, from: data)
                completion(decode,nil)
            } catch {
                completion(nil,error)
            }
        }
        task.resume()
    }
    class func taskforDELETERequest<ResponseType: Decodable>(responseType: ResponseType.Type,completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: EndPoints.Session.url)
        request.httpMethod = "DELETE"
        var xsrfcookie : HTTPCookie? = nil
        let sharedCookie = HTTPCookieStorage.shared
        for cookie in sharedCookie.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfcookie = cookie }
        }
        if let xsrfCookie = xsrfcookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completion(nil,error)
                return
            }
            let range : Range = 5..<data.count
            let newData = data.subdata(in: range)
            
        }.resume()
    }
    class func taskforPOSTSesstion<RequestType: Encodable>(body: RequestType, completion: @escaping (String?, Error?) -> Void) {
        var request = URLRequest(url: EndPoints.Session.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completion(nil,error)
                return
            }
            let range : Range = 5..<data.count
            let newData = data.subdata(in: range)
            do {
                let decoder = JSONDecoder()
                let _ = try decoder.decode(SessionSuccessfulResponse.self, from: newData)
                completion("Success" , nil)
            } catch {
                completion(nil,error)
            }
            completion("failure",error)
        }.resume()
        
    }
    
}
