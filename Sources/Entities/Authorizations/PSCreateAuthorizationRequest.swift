import Foundation
import ObjectMapper

public class PSCreateAuthorizationRequest: Mappable {
    
    public var accountNumber: String!
    public var userIds: [String]!
    public var readPermission: Bool!
    public var writePermission: Bool?
    public var signPermission: PSSignPermission?
    
    required public init?(map: Map) {
        
    }
    
    public init(
        accountNumber: String,
        userIds: [String],
        readPermission: Bool,
        writePermission: Bool? = nil,
        signPermission: PSSignPermission? = nil
        ) {
        self.accountNumber = accountNumber
        self.userIds = userIds
        self.readPermission = readPermission
        self.writePermission = writePermission
        self.signPermission = signPermission
    }
    
    public func mapping(map: Map) {
        accountNumber       <- map["account_number"]
        userIds             <- map["user_ids"]
        readPermission      <- map["read_permission"]
        writePermission     <- map["write_permission"]
        signPermission      <- map["sign_permission"]
    }
}
