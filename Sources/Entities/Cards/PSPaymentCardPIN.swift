import ObjectMapper

public class PSPaymentCardPIN: Mappable {
    public var pinCode: String
    
    required public init?(map: Map) {
        do {
            pinCode = try map.value("pin_code")
            
        } catch {
            print(error)
            return nil
        }
    }
    
    public func mapping(map: Map) {
        pinCode      <- map["pin_code"]
    }
}
