import Foundation
import Alamofire

struct CompositeEncoding: ParameterEncoding {
    
    static var `default` = CompositeEncoding()
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        guard let parameters = parameters else {
            return try urlRequest.asURLRequest()
        }
        
        let queryParamters = (parameters["query"] as! Parameters)
        let bodyParameters = (parameters["body"] as! Parameters)
        
        let queryRequest = try URLEncoding(destination: .queryString).encode(urlRequest, with: queryParamters)
        let bodyRequest = try JSONEncoding().encode(urlRequest, with: bodyParameters)
        
        var compositeRequest = bodyRequest
        compositeRequest.url = queryRequest.url
        return compositeRequest
    }
}
