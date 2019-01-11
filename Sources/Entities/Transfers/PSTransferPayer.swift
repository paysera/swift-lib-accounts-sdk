import ObjectMapper

public class PSTransferPayer: Mappable {
    public var accountNumber: String?
    public var reference: String?

    required public init?(map: Map) {
    }

    public func mapping(map: Map) {
        accountNumber   <- map["account_number"]
        reference       <- map["reference"]
    }
}
