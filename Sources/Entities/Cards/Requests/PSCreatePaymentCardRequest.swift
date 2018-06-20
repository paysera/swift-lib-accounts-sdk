import ObjectMapper

/// The entity class to order new payment card
public class PSCreatePaymentCardRequest: Mappable {

    public private(set) var cardOwnerId: Int?
    public private(set) var shippingAddress: PSPaymentCardShippingAddress?
    public private(set) var deliveryType: String?
    public private(set) var accountNumber: String?
    public private(set) var accountOwnerId: Int?
    public private(set) var chargeInfo: PSChargeInfo?
    
    required public init?(map: Map) {
    }
    
    /// init PSCreatePaymentCardRequest. Required fields should be filled, to be able to post request for a new card ordering.
    ///
    /// - Parameters:
    ///   - cardOwnerId: user id which owns a card - required field
    ///   - shippingAddress: shipping address - required field
    ///   - deliveryType: required field - acceptable values: regular, registered_post, dhl
    ///   - accountOwnerId: user id which owns a account but not necessarily a card. - optional field, 'account_number' or 'account_owner_id' is required.
    ///   - accountNumber: wallet account number - optional field, 'account_number' or 'account_owner_id' is required.
    ///   - chargeInfo: required field
    public init(cardOwnerId: Int, shippingAddress: PSPaymentCardShippingAddress, deliveryType: String, accountOwnerId:  Int? = nil, accountNumber: String? = nil, chargeInfo: PSChargeInfo?) {
        
        self.cardOwnerId = cardOwnerId
        self.shippingAddress = shippingAddress
        self.accountOwnerId = accountOwnerId
        self.accountNumber = accountNumber
        self.chargeInfo = chargeInfo
        self.deliveryType = deliveryType
    }
    
    public func mapping(map: Map) {
        cardOwnerId     <- map["card_owner_id"]
        accountNumber   <- map["account_number"]
        accountOwnerId  <- map["account_owner_id"]
        chargeInfo      <- map["charge_info"]
        shippingAddress <- map["shipping_address"]
        deliveryType    <- map["delivery_type"]
    }
}
