import ObjectMapper

public class PSPayseraOfficeAddress: Mappable {
    public var name: String?
    public var country: String?
    public var city: String?
    public var address: String?
    public var postalCode: String?
    public var officeId: String?
    public var shipmentCode: String?
    
    required public init?(map: Map) { }
    
    public func mapping(map: Map) {
        name         <- map["name"]
        country      <- map["country"]
        city         <- map["city"]
        address      <- map["address"]
        postalCode   <- map["postal_code"]
        officeId     <- map["office_id"]
        shipmentCode <- map["shipment_code"]
    }
}
