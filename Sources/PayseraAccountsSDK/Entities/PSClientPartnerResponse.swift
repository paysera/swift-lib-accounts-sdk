import ObjectMapper

public class PSClientPartnerResponse: Mappable {
    public var partnerID: String!
    
    required public init?(map: Map) { }
    
    public func mapping(map: Map) {
        partnerID   <- map["partner_id"]
    }
}
