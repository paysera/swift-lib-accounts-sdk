import ObjectMapper

public class PSCreatePaymentCardRequest: Mappable {

    public var cardOwnerId: Int?
    public var shippingAddress: PSPaymentCardShippingAddress?
    public var deliveryType: String?
    public var accountNumber: String?
    public var accountOwnerId: Int?
    public var chargeInfo: PSChargeInfo?
    
    required public init?(map: Map) {
    }
    
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
