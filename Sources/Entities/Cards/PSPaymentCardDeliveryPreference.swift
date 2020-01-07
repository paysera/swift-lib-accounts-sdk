import ObjectMapper

public class PSPaymentCardDeliveryPreference: Mappable {
    
    public var ownerId: Int!
    public var shippingAddress: PSPaymentCardShippingAddress!
    public var deliveryType: String!
    
    public init() {}
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        ownerId         <- map["preference_owner_id"]
        shippingAddress <- map["shipping_address"]
        deliveryType    <- map["delivery_type"]
    }
}
