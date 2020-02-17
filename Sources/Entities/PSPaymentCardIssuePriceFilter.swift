//
//  PSPaymentCardIssuePriceFilter.swift
//  PayseraAccountsSDK
//
//  Created by alvin joseph valdez on 2/14/20.
//  Copyright © 2020 Paysera. All rights reserved.
//

import Foundation
import ObjectMapper
import PayseraCommonSDK

//open class PSPaymentCardIssuePriceFilter: ObjectMapper.Mappable {
//
//    public var cardAccountOwnerId: Int?
//    public var cardOwnerId: Int?

//    required public init?(map: Map) {
//        do {
//            cardAccountOwnerId = try map.value("card_account_owner_id")
//            cardOwnerId  = try map.value("card_owner_id")
//        } catch {
//            print(error.localizedDescription)
//            return nil
//        }
//    }
//
//    public init(cardAccountOwnerId: Int, cardOwnerId: Int) {
//        self.cardAccountOwnerId = cardAccountOwnerId
//        self.cardOwnerId = cardOwnerId
//    }
    
//    open func mapping(map: Map) {
//        cardAccountOwnerId <- map["card_account_owner_id"]
//        cardOwnerId  <- map["card_owner_id"]
//    }
//}


public class PSPaymentCardIssuePriceFilter: PSBaseFilter {
    public var cardAccountOwnerId: Int!
    public var cardOwnerId: Int!
    
    public override func mapping(map: Map) {
        super.mapping(map: map)        
        cardAccountOwnerId      <- map["card_account_owner_id"]
        cardOwnerId             <- map["card_owner_id"]
    }
}
