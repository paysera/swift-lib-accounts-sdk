import ObjectMapper

public class PSClientPartner: Mappable {
    public var code: String!
    public var covenanteeId: String!
    
    required public init?(map: Map) { }
    
    public func mapping(map: Map) {
        code            <- map["code"]
        covenanteeId    <- map["covenantee_id"]
    }
}
