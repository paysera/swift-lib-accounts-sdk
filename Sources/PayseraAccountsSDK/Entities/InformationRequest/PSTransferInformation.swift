import ObjectMapper
import PayseraCommonSDK
import Foundation

public class PSTransferInformation: Mappable {
    
    public var amount: PSMoney!
    public var direction: String!
    public var otherParty: PSTransferBeneficiary!
    public var purposeDetails: String!
    public var createdAt: TimeInterval?

    public init() {}
    
    required public init?(map: Map) {}

    public func mapping(map: Map) {
        amount            <- map["amount"]
        direction         <- map["direction"]
        otherParty        <- map["other_party"]
        purposeDetails    <- map["purpose_details"]
        createdAt         <- map["created_at"]
    }
}
