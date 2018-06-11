import ObjectMapper

/// The entity class describing payment card
public class PSPaymentCard: Mappable {
    
    public var id: Int
    public var cardOwnerId: Int
    public var accountOwnerId: Int?
    public var nameOnCard: String?
    public var maskedNumber: String?
    public var accountNumber: String?
    
    public var chargeInfo: PSChargeInfo?
    public var shippingAddress: PSPaymentCardShippingAddress?
    
    public var status: String?
    public var expirationDate: String?
    
    
    public var orderDate: Date?
    public var shippingDate: Date?
    public var main: Bool?
    public var deliveryType: String?
    public var deliveryPrice: PSMoney?
    public var account: PSPayemntCardAccount?
    
    public func mapping(map: Map) {
        id              <- map["id"]
        cardOwnerId     <- map["card_owner_id"]
        accountOwnerId  <- map["account_owner_id"]
        nameOnCard      <- map["name_on_card"]
        maskedNumber    <- map["masked_number"]
        accountNumber   <- map["account_number"]
        chargeInfo      <- map["charge_info"]
        shippingAddress <- map["shipping_address"]
        status          <- map["status"]
        expirationDate  <- map["expiration_date"]
        orderDate       <- (map["order_date"], DateTransform())
        shippingDate    <- (map["shipping_date"], DateTransform())
        main            <- map["main"]
        deliveryType    <- map["delivery_type"]
        deliveryPrice   <- map["delivery_price_amount"]
        account         <- map["account"]
    }
    
    required public init?(map: Map) {
        do {
            id = try map.value("id")
            cardOwnerId = try map.value("card_owner_id")
        } catch {
            print(error)
            return nil
        }
    }
}
