import ObjectMapper

public class PSInformationRequestUploadedFile: Mappable {
    
    public var hash: String!
    public var filename: String!
    
    public init() {}
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        hash        <- map["hash"]
        filename    <- map["filename"]
    }
}
