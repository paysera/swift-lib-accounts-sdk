import ObjectMapper

public class PSPaymentCardIssuePriceFilter: Mappable {
    public var cardAccountOwnerId: String!
    public var cardOwnerId: String!
    
    public init() {}
    
    required public init?(map: Map) { }
    
    public func mapping(map: Map) {
        cardAccountOwnerId      <- map["card_account_owner_id"]
        cardOwnerId             <- map["card_owner_id"]
    }
}
