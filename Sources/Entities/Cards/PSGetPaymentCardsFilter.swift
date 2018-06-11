import ObjectMapper

/// The entity class to get payment cards
public class PSGetPaymentCardsFilter: Mappable {
    
    public var limit: Int?
    public var offset: Int?
    public var orderBy: String?
    public var orderDirection: String?
    public var accountNumbers: [String]?
    public var statuses: [String]?
    public var cardOwnerId: String?
    public var accountOwnerId: String?
    
    required public init?(map: Map) {
        
    }
    
    /// init PSGetPaymentCardsFilter. One of account_numbers, card_owner_id or account_owner_id must be filled
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
