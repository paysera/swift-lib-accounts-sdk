import ObjectMapper

public class PSTransferInitiator: Mappable {
    public var userId: Int?
    public var clientId: Int?

    required public init?(map: Map) {
    }

    // Mappable
    public func mapping(map: Map) {
        userId          <- map["user_id"]
        clientId        <- map["client_id"]
    }
}
