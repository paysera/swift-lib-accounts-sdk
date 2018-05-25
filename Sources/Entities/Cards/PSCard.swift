import ObjectMapper

public class PSCard: Mappable {
    
    public var id: Int = 0
    public var cardOwnerId: Int = 0
    public var accountOwnerId: Int?
    public var nameOnCard: String?
    public var maskedNumber: String?
    public var accountNumber: String?
    
    public var chargeInfo: PSChargeInfo?
    public var shippingAddress: PSCardShippingAddress?
    
    public var status: String?
    public var expirationDate: String?
    
    
    public var orderDate: Date?
    public var shippingDate: Date?
    public var main: Bool?
    public var deliveryType: String?
    public var deliveryPrice: PSMoney?
    public var account: PSCardAccount?
    
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
        orderDate       <- map["order_date"]
        shippingDate    <- map["shipping_date"]
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
    
    public init() {
    }
    
    /// init PSCard with required fields to be able to post request for new card ordering
    ///
    /// - Parameters:
    ///   - chargeInfo: charge order
    ///   - cardOwnerId: user id which owns a card
    ///   - shippingAddress: shipping address
    ///   - deliveryType: regular, registered_post, dhl
    ///   - accountOwnerId: user id which owns a account but not necessarily a card
    public init(chargeInfo: PSChargeInfo, cardOwnerId: Int, shippingAddress: PSCardShippingAddress, deliveryType: String, accountOwnerId:  Int) {
        self.chargeInfo = chargeInfo
        self.cardOwnerId = cardOwnerId
        self.accountOwnerId = accountOwnerId
        self.shippingAddress = shippingAddress
        self.deliveryType = deliveryType
    }
}
