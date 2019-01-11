import ObjectMapper

public class PSTransferBeneficiary: Mappable {
    public let name: String
    public let type: String
    public var beneficiaryPayseraAccount: PSTransferBeneficiaryPayseraAccount?
    public var beneficiaryBankAccount: PSTransferBeneficiaryBankAccount?
    public var beneficiaryTaxAccount: PSTransferBeneficiaryTaxAccount?
    public var beneficiaryWebmoneyAccount: PSTransferBeneficiaryWebmoneyAccount?

    required public init?(map: Map) {
        do {
            name = try map.value("name")
            type = try map.value("type")

        } catch {
            return nil
        }
    }

    public func mapping(map: Map) {
        beneficiaryPayseraAccount   <- map["paysera_account"]
        beneficiaryBankAccount      <- map["bank_account"]
        beneficiaryTaxAccount       <- map["tax_account"]
        beneficiaryWebmoneyAccount  <- map["webmoney_account"]
    }

    public func isBankAccount() -> Bool {
        return beneficiaryBankAccount != nil
    }

    public func isWebmoneyAccount() -> Bool {
        return beneficiaryWebmoneyAccount != nil
    }

    public func isTaxAccount() -> Bool {
        return beneficiaryTaxAccount != nil
    }

    public func isPayseraAccount() -> Bool {
        return beneficiaryPayseraAccount != nil
    }
}

public class PSTransferBeneficiaryTaxAccount: Mappable {
    public var identifier: String?

    required public init?(map: Map) {
    }

    public func mapping(map: Map) {
        identifier <- map["identifier"]
    }
}

public class PSTransferBeneficiaryBankAccount: Mappable {
    public var iban: String?
    public var bic: String?
    public var bankTitle: String?
    public var sortCode: String?
    public var accountNumber: String?
    public var countryCode: String?

    required public init?(map: Map) {
    }

    public func mapping(map: Map) {
        iban            <- map["iban"]
        bic             <- map["bic"]
        bankTitle       <- map["bank_title"]
        sortCode        <- map["sort_code"]
        accountNumber   <- map["account_number"]
        countryCode     <- map["country_code"]
    }
}

public class PSTransferBeneficiaryPayseraAccount: Mappable {
    public var phone: String?
    public var email: String?
    public var accountNumber: String?
    public var userId: Int

    required public init?(map: Map) {
        do {
            userId = try map.value("user_id")

        } catch {
            return nil
        }
    }

    public func mapping(map: Map) {
        userId          <- map["user_id"]
        phone           <- map["phone"]
        email           <- map["email"]
        accountNumber   <- map["account_number"]
    }
}

public class PSTransferBeneficiaryWebmoneyAccount: Mappable {
    public var purse: String?

    required public init?(map: Map) {
    }

    public func mapping(map: Map) {
        purse <- map["purse"]
    }
}
