import ObjectMapper

public class PSInformationRequestRequestedDocuments: Mappable {
    
    public var instructions: String!
    public var documents: [String]!
    
    public init() {}
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        instructions    <- map["instructions"]
        documents       <- map["documents"]
    }
}
