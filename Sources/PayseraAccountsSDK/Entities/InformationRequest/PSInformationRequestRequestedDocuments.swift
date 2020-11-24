import ObjectMapper

public class PSInformationRequestRequestedDocuments: Mappable {
    
    public var question: String?
    public var documents: [String]!
    
    public init() {}
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        question     <- map["question"]
        documents    <- map["documents"]
    }
}
