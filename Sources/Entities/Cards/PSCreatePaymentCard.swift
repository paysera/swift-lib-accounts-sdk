import ObjectMapper

/// The entity class to order new payment card
public class PSCreatePaymentCard: Mappable {
    
    public var cardOwnerId: Int!
    public var accountNumber: String?
    public var shippingAddress: PSPaymentCardShippingAddress!
    public var accountOwnerId: Int?
    public var chargeInfo: PSChargeInfo?
    public var deliveryType: String!
    
    
    public func mapping(map: Map) {
        cardOwnerId     <- map["card_owner_id"]
        accountNumber   <- map["account_number"]
        accountOwnerId  <- map["account_owner_id"]
        chargeInfo      <- map["charge_info"]
        shippingAddress <- map["shipping_address"]
        deliveryType    <- map["delivery_type"]
    }
    
    required public init?(map: Map) {
    }
    
    /// init PSCreatePaymentCard. Required fields should be filled, to be able to post request for new card ordering.
    ///
    /// - Parameters:
    ///   - cardOwnerId: user id which owns a card - required field
    ///   - shippingAddress: shipping address - required field
    ///   - accountOwnerId: user id which owns a account but not necessarily a card. - optional field, 'account_number' or 'account_owner_id' is required.
    ///   - accountNumber: wallet account number - optional field, 'account_number' or 'account_owner_id' is required.
    ///   - chargeInfo: required field
    ///   - deliveryType: required field - acceptable values: regular, registered_post, dhl
    public init(cardOwnerId: Int, shippingAddress: PSPaymentCardShippingAddress, accountOwnerId:  Int? = nil, accountNumber: String? = nil, chargeInfo: PSChargeInfo?, deliveryType: String) {
        
        self.cardOwnerId = cardOwnerId
        self.shippingAddress = shippingAddress
        self.accountOwnerId = accountOwnerId
        self.accountNumber = accountNumber
        self.chargeInfo = chargeInfo
        self.deliveryType = deliveryType
    }
}
