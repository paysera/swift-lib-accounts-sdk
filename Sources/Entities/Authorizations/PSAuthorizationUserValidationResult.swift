import ObjectMapper

public class PSAuthorizationUserValidationResult: Mappable {
    
    public var userId: Int!
    public var valid: Bool!
    public var reason: String?
    
    public init() {}
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        userId      <- map["user_id"]
        valid       <- map["valid"]
        reason      <- map["reason"]
    }
}
