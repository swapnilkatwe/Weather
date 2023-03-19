
import Foundation
import  Alamofire

final class AlamofireManager {
    class func executeRequest(_ url: String,
                              method: HTTPMethod = .get,
                              param: Parameters? = nil,
                              encoding: ParameterEncoding = JSONEncoding.default,
                              header: HTTPHeaders? = nil,
                              interceptor: RequestInterceptor? = nil,
                              completion: @escaping (Result<Data>) -> Void) {
        
        AF.request(url, method: method, parameters: param, encoding: encoding, headers: header, interceptor: interceptor)
            .validate(statusCode: 200..<300)
            .responseData { response in
                
                guard let json = response.result.value
                else {
                    let userInfo = "api-error"
                    let error = NSError(domain: "", code: 902, userInfo: [NSLocalizedDescriptionKey: userInfo as Any])
                    
                    completion(.failure(error))
                    return
                }
                switch response.result {
                case .success:
                    completion(.success(json))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
