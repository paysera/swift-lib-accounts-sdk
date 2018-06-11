import ObjectMapper

/// The entity class describing payment card info
public class PSPayemntCardAccount: Mappable {
    
    public var number: String
    public var clientId: Int
    public var ownerId: Int
    public var createdAt: TimeInterval
    public var active: Bool
    public var closed: Bool
    public var type: String
    public var client: PSPaymentCardClient?
    public var ibanList: [String]?
    
    public func mapping(map: Map) {
        number          <- map["number"]
        clientId        <- map["client_id"]
        ownerId         <- map["owner_id"]
        createdAt       <- map["created_at"]
        active          <- map["active"]
        closed          <- map["closed"]
        type            <- map["type"]
        client          <- map["client"]
        ibanList        <- map["iban_list"]
    }
    
    required public init?(map: Map) {
        do {
            number = try map.value("number")
            clientId = try map.value("client_id")
            ownerId = try map.value("owner_id")
            createdAt = try map.value("created_at")
            active = try map.value("active")
            closed = try map.value("closed")
            type = try map.value("type")
            
        } catch {
            print(error)
            return nil
        }
    }
}
