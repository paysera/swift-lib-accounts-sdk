import ObjectMapper

public class PSFile: Mappable {
    public var content: String!
    public var filename: String!
    
    public init() {}
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        content     <- map["content"]
        filename    <- map["filename"]
    }
}
