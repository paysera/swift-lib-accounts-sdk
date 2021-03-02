import ObjectMapper

public class PSAccountAuthorizationAllowance: Mappable {
    
    public var accountNumber: String!
    public var allowed: Bool = false
    
    required public init?(map: Map) { }
    
    public func mapping(map: Map) {
        accountNumber   <- map["account_number"]
        allowed         <- map["allowed"]
    }
}
