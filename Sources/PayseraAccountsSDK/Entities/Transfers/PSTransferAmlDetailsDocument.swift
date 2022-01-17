import Foundation
import ObjectMapper

public class PSTransferAmlDetailsDocument: Mappable {
    public var hash: String!
    
    public init() {}
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        hash    <- map["hash"]
    }
}
