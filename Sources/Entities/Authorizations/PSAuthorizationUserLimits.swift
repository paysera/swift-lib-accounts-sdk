import ObjectMapper

public class PSAuthorizationUserLimits: Mappable {
    
    public var `default`: PSAuthorizationUserLimit?
    public var maximum: PSAuthorizationUserLimit?
    
    public init() {}
    
    required public init?(map: Map) { }
    
    public func mapping(map: Map) {
        `default`   <- map["default_signing_limits"]
        maximum     <- map["maximum_signing_limits"]
    }
}
