import ObjectMapper

public class PSInformationRequestAnswers: Mappable {
    
    public var answers: [PSInformationRequestAnswer]!
    
    public init() {}
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        answers    <- map["answers"]
    }
}

public class PSInformationRequestAnswer: Mappable {
    
    public var answer: String!
    public var questionId: String!
    
    public init() {}
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        answer      <- map["answer"]
        questionId  <- map["question_id"]
    }
}
