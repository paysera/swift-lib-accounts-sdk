import Alamofire
import Foundation

struct CompositeEncoding: ParameterEncoding {
    
    static var `default` = CompositeEncoding()
    
    public func encode(
        _ urlRequest: URLRequestConvertible,
        with parameters: Parameters?
    ) throws -> URLRequest {
        guard let parameters = parameters else {
            return try urlRequest.asURLRequest()
        }
        
        var compositeRequest: URLRequest!
        
        if let bodyParameters = parameters["body"] as? Parameters {
            compositeRequest = try JSONEncoding().encode(urlRequest, with: bodyParameters)
        } else {
            compositeRequest = try JSONEncoding().encode(urlRequest)
        }
        
        if let queryParamters = (parameters["query"] as? Parameters) {
            compositeRequest.url = try URLEncoding(destination: .queryString).encode(
                urlRequest,
                with: queryParamters
            ).url
        }
        
        return compositeRequest
    }
}
