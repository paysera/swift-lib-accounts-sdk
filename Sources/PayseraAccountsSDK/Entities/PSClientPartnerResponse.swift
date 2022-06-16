import ObjectMapper

public class PSClientPartnerResponseItem: Mappable {
    public var code: String!
    public var covenanteeId: String!
    
    required public init?(map: Map) { }
    
    public func mapping(map: Map) {
        code   <- map["code"]
        covenanteeId <- map["covenantee_id"]
    }
}

public class PSClientPartnerResponse: Mappable {
    public var items: [PSClientPartnerResponseItem]!
    
    required public init?(map: Map) { }
    
    public func mapping(map: Map) {
        items   <- map["items"]
    }
}
