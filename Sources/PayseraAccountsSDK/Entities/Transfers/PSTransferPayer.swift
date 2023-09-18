import ObjectMapper

public class PSTransferPayer: Mappable {
    public var accountNumber: String?
    public var reference: String?
    public var name: String?
    public var userId: Int?
    public var clientIdentifier: PSClientIdentifier?

    public init() {}
    
    required public init?(map: Map) {
    }

    public func mapping(map: Map) {
        accountNumber     <- map["account_number"]
        reference         <- map["reference"]
        name              <- map["name"]
        userId            <- map["user_id"]
        clientIdentifier  <- map["client_identifier"]
    }
}
