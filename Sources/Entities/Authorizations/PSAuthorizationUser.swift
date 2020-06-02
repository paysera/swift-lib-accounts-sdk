import ObjectMapper

public class PSAuthorizationUser: Mappable {
    
    public var userId: Int?
    public var displayName: String!
    
    public init() {}
    
    required public init?(map: Map) { }
    
    public func mapping(map: Map) {
        userId          <- map["user_id"]
        displayName     <- map["display_name"]
    }
}
