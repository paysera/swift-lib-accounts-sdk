import ObjectMapper

public class PSPaymentCardDeliveryPreference: Mappable {
    
    public var ownerId: Int
    public var shippingAddress: PSPaymentCardShippingAddress
    public var deliveryType: String
    
    
    required public init?(map: Map) {
        do {
            ownerId = try map.value("preference_owner_id")
            shippingAddress = try map.value("shipping_address")
            deliveryType = try map.value("delivery_type")
        } catch {
            print(error)
            return nil
        }
    }
    
    public init(ownerId: Int, shippingAddress: PSPaymentCardShippingAddress, deliveryType: String) {
        self.ownerId = ownerId
        self.shippingAddress = shippingAddress
        self.deliveryType = deliveryType
    }
    
    public func mapping(map: Map) {
        ownerId         <- map["preference_owner_id"]
        shippingAddress <- map["shipping_address"]
        deliveryType    <- map["delivery_type"]
    }
}
