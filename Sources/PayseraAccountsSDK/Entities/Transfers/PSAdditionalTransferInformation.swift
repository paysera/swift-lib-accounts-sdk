import ObjectMapper

public class PSAdditionalTransferInformation: Mappable {
    public var hash: String!
    public var description: String!
    public var fundsOrigin: String!
    public var documents: [PSTransferAmlDetailsDocument]!
    
    public init() {}
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        hash           <- map["hash"]
        description    <- map["description"]
        fundsOrigin    <- map["funds_origin"]
        documents      <- map["documents"]
    }
}
