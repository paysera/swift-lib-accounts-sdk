import ObjectMapper

public enum PSClientIdentifierType: String {
    case personalNumber = "personal_number"
    case customerCode = "customer_code"
    case taxPayerCode = "tax_payer_code"
    case passportNumber = "passport_number"
    case companyCode = "company_code"
}

public class PSClientIdentifier: Mappable {
    public var type: String?
    public var value: String?
    
    public init() {}
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        type    <- map["type"]
        value   <- map["value"]
    }
}
