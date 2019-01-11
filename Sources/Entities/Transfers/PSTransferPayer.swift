import ObjectMapper

public class PSTransferPayer: Mappable {
    public var accountNumber: String?

    required public init?(map: Map) {
    }

    public func mapping(map: Map) {
        accountNumber <- map["account_number"]
    }
}
