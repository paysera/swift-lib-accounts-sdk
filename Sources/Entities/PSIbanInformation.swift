import Foundation
import ObjectMapper

public class PSIbanInformation: Mappable {    
    public var swift: String?
    public var bankName: String?
    public var bankCode: String?
    public var country: String?
    
    required public init?(map: Map) {

    }
    
    public func mapping(map: Map) {
        swift           <- map["swift"]
        bankName        <- map["bank_name"]
        bankCode        <- map["bank_code"]
        country         <- map["country"]
    }
}
