import ObjectMapper

public class PSClientPartnerResponse: Mappable {
    public var items: [String]!
    
    required public init?(map: Map) { }
    
    public func mapping(map: Map) {
        items   <- map["items"]
    }
}
