import Foundation
import PayseraCommonSDK
import ObjectMapper

public class PSCreateAuthorizationRequest: Mappable {
    
    public var accountNumber: String!
    public var userIds: [String]!
    public var readPermission = false
    public var writePermission = false
    public var signPermission: PSCreateAuthorizationRequestSignPermission?
    
    required public init?(map: Map) {
        
    }
    
    public init(
        accountNumber: String,
        userIds: [String],
        signPermission: PSCreateAuthorizationRequestSignPermission? = nil
        ) {
        self.accountNumber = accountNumber
        self.userIds = userIds
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

public class PSCreateAuthorizationRequestSignPermission {
    
    public var level: String!
    public var dayLimit: PSMoney?
    public var monthLimit: PSMoney?
    public var yearLimit: PSMoney?
    public var forAutomaticTransfers = false
    
    public init(level: String) {
        self.level = level
    }
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        level                   <- map["level"]
        dayLimit                <- map["day_limit"]
        monthLimit              <- map["month_limit"]
        yearLimit               <- map["year_limit"]
        forAutomaticTransfers   <- map["for_automatic_transfers"]
    }
    
}
