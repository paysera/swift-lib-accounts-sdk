import Foundation
import ObjectMapper
import PayseraCommonSDK

public class PSPaymentCardIssuePriceFilter: PSBaseFilter {
    public var cardAccountOwnerId: Int!
    public var cardOwnerId: Int!
    
    public override func mapping(map: Map) {
        super.mapping(map: map)        
        cardAccountOwnerId      <- map["card_account_owner_id"]
        cardOwnerId             <- map["card_owner_id"]
    }
}