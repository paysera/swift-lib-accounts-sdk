import ObjectMapper

public class PSSpreadPercentageRequest: Mappable {
    public var accountNumber: String!
    public var fromCurrency: String!
    public var toCurrency: String!
    public var toAmount: String!

    public init(
        accountNumber: String,
        fromCurrency: String,
        toCurrency: String,
        toAmount: String
    ) {
        self.accountNumber = accountNumber
        self.fromCurrency = fromCurrency
        self.toCurrency = toCurrency
        self.toAmount = toAmount
    }

    required public init?(map: Map) {}

    public func mapping(map: Map) {
        accountNumber   <- map["account_number"]
        fromCurrency    <- map["from_currency"]
        toCurrency      <- map["to_currency"]
        toAmount        <- map["to_amount"]
    }
}
