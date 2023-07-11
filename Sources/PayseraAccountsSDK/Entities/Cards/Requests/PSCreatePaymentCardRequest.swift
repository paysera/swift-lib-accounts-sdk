import ObjectMapper

public class PSCreatePaymentCardRequest: Mappable {

    public var cardOwnerId: Int?
    public var shippingAddress: PSPaymentCardShippingAddress?
    public var travelerAddress: PSPaymentCardShippingAddress?
    public var officeId: String?
    public var deliveryType: String?
    public var accountNumber: String?
    public var accountOwnerId: Int?
    public var chargeInfo: PSChargeInfo?
    public var visualType: String?
    
    required public init?(map: Map) {
    }
    
    public init(
        cardOwnerId: Int,
        shippingAddress: PSPaymentCardShippingAddress,
        travelerAddress: PSPaymentCardShippingAddress?,
        officeId: String?,
        deliveryType: String,
        accountOwnerId: Int? = nil,
        accountNumber: String? = nil,
        chargeInfo: PSChargeInfo? = nil,
        visualType: String? = nil
    ) {
        self.cardOwnerId = cardOwnerId
        self.shippingAddress = shippingAddress
        self.travelerAddress = travelerAddress
        self.officeId = officeId
        self.accountOwnerId = accountOwnerId
        self.accountNumber = accountNumber
        self.chargeInfo = chargeInfo
        self.deliveryType = deliveryType
        self.visualType = visualType
    }
    
    public func mapping(map: Map) {
        cardOwnerId     <- map["card_owner_id"]
        accountNumber   <- map["account_number"]
        accountOwnerId  <- map["account_owner_id"]
        chargeInfo      <- map["charge_info"]
        shippingAddress <- map["shipping_address"]
        travelerAddress <- map["traveler_address"]
        officeId        <- map["office_id"]
        deliveryType    <- map["delivery_type"]
        visualType      <- map["visual_type"]
    }
}
