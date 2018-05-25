import ObjectMapper

public class PSMetaData: Mappable {
    public var total: Int?
    public var offset: Int?
    public var limit: Int?
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        total       <- map["total"]
        offset      <- map["offset"]
        limit       <- map["limit"]
    }
}
