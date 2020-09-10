import PayseraCommonSDK
import ObjectMapper

public class PSUnallocatedBullionBalance: Mappable {
    public var accountNumber: String!
    public var amount: PSMoney!

    public init() {}

    required public init?(map: Map) {}

    public func mapping(map: Map) {
        accountNumber   <- map["account_number"]
        amount          <- map["amount"]
    }
}
