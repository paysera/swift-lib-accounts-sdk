import ObjectMapper

/// The entity class to order new payment card
public class PSRequestPaymentCard: Mappable {
    
    public var cardOwnerId: Int!
    public var shippingAddress: PSPaymentCardShippingAddress!
    public var accountOwnerId: Int?
    public var chargeInfo: PSChargeInfo?
    public var deliveryType: String!
    
    
    public func mapping(map: Map) {
        cardOwnerId     <- map["card_owner_id"]
        accountOwnerId  <- map["account_owner_id"]
        chargeInfo      <- map["charge_info"]
        shippingAddress <- map["shipping_address"]
        deliveryType    <- map["delivery_type"]
    }
    
    required public init?(map: Map) {
    }
    
    /// init PSRequestPaymentCard. Required fields should be filled, to be able to post request for new card ordering. One of the fields either 'account_number' or 'account_owner_id' is required.
    ///
    /// - Parameters:
    ///   - cardOwnerId: user id which owns a card - required field
    ///   - shippingAddress: shipping address - required field
    ///   - accountOwnerId: user id which owns a account but not necessarily a card. One of the fields either 'chargeInfo.accountNumber' or 'accountOwnerId' is required
    ///   - chargeInfo: One of the fields either 'chargeInfo.accountNumber' or 'accountOwnerId' is required
    ///   - deliveryType: required field - acceptable values: regular, registered_post, dhl
    public init(cardOwnerId: Int, shippingAddress: PSPaymentCardShippingAddress, accountOwnerId:  Int?, chargeInfo: PSChargeInfo?, deliveryType: String) {
        
        self.cardOwnerId = cardOwnerId
        self.shippingAddress = shippingAddress
        self.accountOwnerId = accountOwnerId
        self.chargeInfo = chargeInfo
        self.deliveryType = deliveryType
    }
}
