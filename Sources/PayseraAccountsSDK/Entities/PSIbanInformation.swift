import ObjectMapper

public class PSIbanInformation: Mappable {    
    public var swift: String?
    public var bankName: String?
    public var bankCode: String?
    public var country: String?
    public var branchCode: String?
    public var sepaParticipant = false
    public var sepaInstantParticipant = false
    public var target2Participant = false
    
    required public init?(map: Map) {

    }
    
    public func mapping(map: Map) {
        swift                  <- map["swift"]
        bankName               <- map["bank_name"]
        bankCode               <- map["bank_code"]
        country                <- map["country"]
        branchCode             <- map["branch_code"]
        sepaParticipant        <- map["sepa_participant"]
        sepaInstantParticipant <- map["sepa_instant_participant"]
        target2Participant <- map["target2_participant"]
    }
}
