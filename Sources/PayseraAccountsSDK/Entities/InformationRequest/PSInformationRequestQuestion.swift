import ObjectMapper

public class PSInformationRequestQuestion: Mappable {
    
    public var id: String?
    public var question: String!
    public var inputType: String!
    public var isRequired: Bool!
    public var answer: String?
    
    public init() {}
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        id           <- map["id"]
        question     <- map["question"]
        inputType    <- map["input_type"]
        isRequired   <- map["required"]
        answer       <- map["answer"]
    }
}
