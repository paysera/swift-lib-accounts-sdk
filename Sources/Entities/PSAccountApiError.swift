import Foundation
import ObjectMapper

public class PSAccountApiError: Mappable, Error {
    public var error: String!
    public var description: String?
    
    init(error: String, description: String? = nil) {
        self.error = error
        self.description = description
    }
    
    required public init?(map: Map) {    
    }
    
    public func mapping(map: Map) {
        error        <- map["error"]
        description  <- map["error_description"]
    }
    
    func isUnauthorized() -> Bool {
        return error == "unauthorized"
    }
    
    class func unknown() -> PSAccountApiError {
        return PSAccountApiError(error: "unknown")
    }
    
    class func unauthorized() -> PSAccountApiError {
        return PSAccountApiError(error: "unauthorized")
    }
}
