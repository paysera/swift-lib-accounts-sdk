import ObjectMapper
import PayseraCommonSDK

public final class PSPaymentCardDeliveryPrice: Mappable {
    public var price: PSMoney
    public var country: String
    public var deliveryType: String
    
    required public init?(map: Map) {
        do {
            price = try map.value("price")
            country = try map.value("country")
            deliveryType = try map.value("delivery_type")
        } catch {
            print(error)
            return nil
        }
    }
    
    public func mapping(map: Map) {
        price           <- map["price"]
        country         <- map["country"]
        deliveryType    <- map["delivery_type"]
    }
}
