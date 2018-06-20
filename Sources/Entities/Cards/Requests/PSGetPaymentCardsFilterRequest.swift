import ObjectMapper

/// The entity class to get payment cards
public class PSGetPaymentCardsFilterRequest: Mappable {
    
    public private(set) var limit: Int?
    public private(set) var offset: Int?
    public private(set) var orderBy: String?
    public private(set) var orderDirection: String?
    public private(set) var accountNumbers: [String]?
    public private(set) var statuses: [String]?
    public private(set) var cardOwnerId: String?
    public private(set) var accountOwnerId: String?
    
    required public init?(map: Map) {
        
    }
    
    /// init PSGetPaymentCardsFilterRequest. One of account_numbers, card_owner_id or account_owner_id must be filled
    ///
    /// - Parameters:
    ///   - accountNumbers: array of user payment cards numbers
    ///   - cardOwnerId: optional
    ///   - accountOwnerId: optional
    public init(accountNumbers: [String]? = nil, cardOwnerId: String? = nil, accountOwnerId: String? = nil) {
        self.accountNumbers = accountNumbers
        self.cardOwnerId = cardOwnerId
        self.accountOwnerId = accountOwnerId
    }
    
    public func mapping(map: Map) {
        limit           <- map["limit"]
        offset          <- map["offset"]
        orderBy         <- map["order_by"]
        orderDirection  <- map["order_direction"]
        accountNumbers  <- map["account_numbers"]
        statuses        <- map["statuses"]
        cardOwnerId     <- map["card_owner_id"]
        accountOwnerId  <- map["account_owner_id"]
    }
    
}
