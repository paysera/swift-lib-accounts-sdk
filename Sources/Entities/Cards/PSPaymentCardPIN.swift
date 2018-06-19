import ObjectMapper

public class PSPaymentCardPIN: Mappable {
    public var pinCode: String
    
    public func mapping(map: Map) {
        pinCode      <- map["pin_code"]
    }
    
    required public init?(map: Map) {
        do {
            pinCode = try map.value("pin_code")
            
        } catch {
            print(error)
            return nil
        }
    }
}
