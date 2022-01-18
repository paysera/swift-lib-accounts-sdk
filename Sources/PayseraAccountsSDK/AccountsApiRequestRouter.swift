import Alamofire
import Foundation
import PayseraCommonSDK

enum AccountsApiRequestRouter {
    case get(path: String, parameters: [String: Any]?)
    case post(path: String, parameters: [String: Any]?)
    case put(path: String, parameters: [String: Any]?)
    case putWithData(path: String, data: Data, contentType: String)
    case delete(path: String, parameters: [String: Any]?)
    
    // MARK: - GET
    case getLastUserQuestionnaire(userId: Int)
    case getIbanInformation(iban: String, currency: String?)
    case getBalance(accountNumber: String, showHistoricalCurrencies: Bool)
    case getPaymentCards(cardsFilter: PSGetPaymentCardsFilterRequest)
    case getPaymentCardDesigns(filter: PSPaymentCardDesignFilter)
    case getPaymentCardLimit(accountNumber: String)
    case getPaymentCardShippingAddress(accountNumber: String)
    case getPaymentCardDeliveryPrices(country: String)
    case getPaymentCardIssuePrice(filter: PSPaymentCardIssuePriceFilter)
    case getPaymentCardDeliveryDate(country: String, deliveryType: String)
    case getPaymentCardDeliveryCountries(filter: PSBaseFilter)
    case getCategorizedAccountNumbers(filter: PSGetCategorizedAccountNumbersFilterRequest)
    case getTransfer(id: String)
    case getAuthorizations(PSGetAuthorizationsFilterRequest)
    case getPaymentCardExpiringCardOrderRestriction(accountNumber: String)
    case getPaymentCardDeliveryPreference(accountNumber: String)
    case getAvailableCurrencies(filter: PSAvailableCurrencyFilter)
    case getPurposeCodes
    case getSigningLimits(userId: Int)
    case getConversionTransfers(filter: PSConversionTransferFilter)
    case getCardOrderRestrictions(cardAccountOwnerId: Int, cardOwnerId: Int)
    case getBankParticipationInfo(swift: String)
    case getBullionItems(filter: PSBullionFilter)
    case getBullionOptions(filter: PSBaseFilter)
    case getUnallocatedBullionBalance(filter: PSBullionFilter)
    case getSpreadPercentage(request: PSSpreadPercentageRequest)
    case getInformationRequests(filter: PSInformationRequestFilter)
    case getClientAllowances
    case getIsAdditionalInformationNeeded(transferID: String)
    
    // MARK: - POST
    case createCard(PSCreatePaymentCardRequest)
    case createAuthorization(PSCreateAuthorizationRequest)
    case createAccount(userId: Int)
    case signConversionTransfer(transferId: String)
    case cancelConversionTransfer(transferId: String)
    case buyBullion(identifier: String, accountNumber: String)
    case sellBullion(hash: String)
    case uploadInformationRequestFile(id: String, file: PSFile)
    case createTransferAmlDetailsDocument
    case uploadTransferAmlDetailsDocumentFile(hash: String, file: PSFile)
    case uploadTransferAmlDetailsDocument(information: PSAdditionalTransferInformation)
    
    // MARK: - PUT
    case deactivateAccount(accountNumber: String)
    case activateAccount(accountNumber: String)
    case activateCard(id: Int, cvv: String)
    case enableCard(id: Int)
    case deactivateCard(id: Int)
    case setPaymentCardLimit(accountNumber: String, cardLimit: PSUpdatePaymentCardLimitRequest)
    case retrievePaymentCardPIN(id: Int, cvv: String)
    case cancelPaymentCard(id: Int)
    case provisionCardForXPay(id: Int, request: PSXpayTokenRequest)
    case activateCardForXPay(id: Int)
    case setAccountDefaultDescription(accountNumber: String, description: String)
    case setAccountDescription(userId: Int, accountNumber: String, description: String)
    case updateAuthorization(id: String, createAuthorizationRequest: PSCreateAuthorizationRequest)
    case setPaymentCardDeliveryPreference(accountNumber: String, preference: PSPaymentCardDeliveryPreference)
    case validateAuthorizationUsers(userIds: [Int])
    case uploadInformationRequestAnswers(id: String, answers: PSInformationRequestAnswers)
    case unblockPaymentCardCVV(cardId: String)
    case uploadAdditionalTransferDetails(transferID: String, hash: String)
    
    // MARK: - Delete
    case deleteAuthorization(id: String)
    case deleteUserFromAuthorization(authorizationId: String, userId: String)
    
    // MARK: - Declarations
    private static let baseURL = URL(string: "https://accounts.paysera.com/public")!
    
    private var method: HTTPMethod {
        switch self {
        case .get,
             .getIbanInformation,
             .getLastUserQuestionnaire,
             .getBalance,
             .getPaymentCards,
             .getPaymentCardDesigns,
             .getPaymentCardLimit,
             .getPaymentCardShippingAddress,
             .getPaymentCardDeliveryPrices,
             .getPaymentCardIssuePrice,
             .getPaymentCardDeliveryDate,
             .getCategorizedAccountNumbers,
             .getTransfer,
             .getPaymentCardDeliveryCountries,
             .getAuthorizations,
             .getPaymentCardDeliveryPreference,
             .getPaymentCardExpiringCardOrderRestriction,
             .getAvailableCurrencies,
             .getPurposeCodes,
             .getSigningLimits,
             .getConversionTransfers,
             .getCardOrderRestrictions,
             .getBankParticipationInfo,
             .getBullionItems,
             .getBullionOptions,
             .getUnallocatedBullionBalance,
             .getSpreadPercentage,
             .getInformationRequests,
             .getClientAllowances,
             .getIsAdditionalInformationNeeded:
            return .get

        case .post,
             .createCard,
             .createAccount,
             .createAuthorization,
             .buyBullion,
             .sellBullion,
             .uploadInformationRequestFile,
             .createTransferAmlDetailsDocument,
             .uploadTransferAmlDetailsDocumentFile,
             .uploadTransferAmlDetailsDocument:
            return .post
            
        case .put,
             .putWithData,
             .activateCard,
             .enableCard,
             .deactivateCard,
             .setPaymentCardLimit,
             .retrievePaymentCardPIN,
             .cancelPaymentCard,
             .provisionCardForXPay,
             .activateCardForXPay,
             .deactivateAccount,
             .activateAccount,
             .setAccountDefaultDescription,
             .updateAuthorization,
             .setAccountDescription,
             .setPaymentCardDeliveryPreference,
             .validateAuthorizationUsers,
             .signConversionTransfer,
             .cancelConversionTransfer,
             .uploadInformationRequestAnswers,
             .unblockPaymentCardCVV,
             .uploadAdditionalTransferDetails:
            return .put

        case .delete,
             .deleteAuthorization,
             .deleteUserFromAuthorization:
            return .delete
        }
    }
    
    private var path: String {
        switch self {
        case .get(let path, _),
             .post(let path, _),
             .put(let path, _),
             .putWithData(let path, _, _),
             .delete(let path, _):
            return path
            
        case .activateAccount(let accountNumber):
            return "/account/rest/v1/accounts/\(accountNumber)/activate"
            
        case .deactivateAccount(let accountNumber):
            return "/account/rest/v1/accounts/\(accountNumber)/deactivate"
            
        case .setAccountDefaultDescription(let accountNumber, _):
            return "/account/rest/v1/accounts/\(accountNumber)/descriptions"
            
        case .getLastUserQuestionnaire(let userId):
            return "/questionnaire/rest/v1/user/\(userId)/questionnaire"
            
        case .getIbanInformation(let iban, _):
            return "/transfer/rest/v1/bank-information/\(iban)"
            
        case .getTransfer(let id):
            return "/transfer/rest/v1/transfers/\(id)"
            
        case .getBalance(let accountNumber, _):
            return "/account/rest/v1/accounts/\(accountNumber)/full-balance"
            
        case .getPaymentCards:
            return "/issued-payment-card/v1/cards"
            
        case .getPaymentCardDesigns:
            return "/issued-payment-card/v1/card-designs"
            
        case .getPaymentCardDeliveryCountries:
            return "/issued-payment-card/v1/card-delivery-countries"
            
        case .getPaymentCardLimit(let accountNumber):
            return "/issued-payment-card/v1/accounts/\(accountNumber)/card-limit"
            
        case .getPaymentCardShippingAddress(let accountNumber):
            return "/issued-payment-card/v1/accounts/\(accountNumber)/shipping-address"
            
        case .getPaymentCardDeliveryPreference(let accountNumber):
            return "/issued-payment-card/v1/accounts/\(accountNumber)/card-delivery-preference"
            
        case .getPaymentCardExpiringCardOrderRestriction(let accountNumber):
            return "/issued-payment-card/v1/accounts/\(accountNumber)/expiring-card-reorder-restriction"

        case .getPaymentCardDeliveryPrices(let country):
            return "/issued-payment-card/v1/card-delivery-prices/\(country)"
            
        case .getPaymentCardIssuePrice:
            return "/issued-payment-card/v1/card-account-issue-price"
            
        case .getPaymentCardDeliveryDate:
            return "/issued-payment-card/v1/card-delivery-date"
            
        case .getCategorizedAccountNumbers:
            return "/transfer/rest/v1/categorized-account-numbers"
            
        case .getCardOrderRestrictions:
            return "/issued-payment-card/v1/card-order-restrictions"
            
        case .getBankParticipationInfo(let swift):
            return "/transfer/rest/v1/bank-participation/\(swift)"
            
        case .getClientAllowances:
            return "/client-allowance/rest/v1/client-allowances"
            
        case .createCard:
            return "/issued-payment-card/v1/cards"
            
        case .activateCard(let id, _):
            return "/issued-payment-card/v1/cards/\(String(id))/activate-card"
            
        case .enableCard(let id):
            return "/issued-payment-card/v1/cards/\(String(id))/enable"
            
        case .deactivateCard(let id):
            return "/issued-payment-card/v1/cards/\(String(id))/deactivate"
            
        case .setPaymentCardLimit(let accountNumber, _):
            return "/issued-payment-card/v1/accounts/\(accountNumber)/card-limit"
            
        case .retrievePaymentCardPIN(let id, _):
            return "/issued-payment-card/v1/cards/\(String(id))/pin"
            
        case .cancelPaymentCard(let id):
            return "/issued-payment-card/v1/cards/\(String(id))/cancel"

        case .provisionCardForXPay(let id, _):
            return "/issued-payment-card/v1/cards/\(String(id))/xpay/add"

        case .activateCardForXPay(let id):
            return "/issued-payment-card/v1/cards/\(String(id))/xpay/activate"
            
        case .createAccount(let userId):
            return "/account/rest/v1/users/\(String(userId))/accounts"
            
        case .setAccountDescription( _,let accountNumber, _):
            return "/account/rest/v1/accounts/\(accountNumber)/descriptions"
            
        case .getAuthorizations:
            return "/permission/rest/v1/authorizations"
            
        case .createAuthorization:
            return "/permission/rest/v1/authorizations"
            
        case .deleteAuthorization(let id):
            return "/permission/rest/v1/authorizations/\(id)"
            
        case .updateAuthorization(let id, _):
            return "/permission/rest/v1/authorizations/\(id)"
            
        case .setPaymentCardDeliveryPreference(let accountNumber, _):
            return "/issued-payment-card/v1/accounts/\(accountNumber)/card-delivery-preference"

        case .getAvailableCurrencies:
            return "/currency/rest/v1/available-currencies"
            
        case .getPurposeCodes:
            return "/transfer/rest/v1/purpose-codes"

        case .deleteUserFromAuthorization(let authorizationId, let userId):
            return "/permission/rest/v1/authorizations/\(authorizationId)/users/\(userId)"
        
        case .getSigningLimits(let userId):
            return "/permission/rest/v1/users/\(userId)/limits"
            
        case .validateAuthorizationUsers:
            return "/permission/rest/v1/authorizations/authorization-user-validation"
            
        case .getConversionTransfers:
            return "/transfer/rest/v1/conversion-transfers"
            
        case .signConversionTransfer(let id):
            return "/transfer/rest/v1/conversion-transfers/\(id)/sign"
            
        case .cancelConversionTransfer(let id):
            return "/transfer/rest/v1/conversion-transfers/\(id)/cancel"
            
        case .getBullionItems:
            return "/bullion/rest/v1/items"

        case .getBullionOptions:
            return "/bullion/rest/v1/item-options"

        case .getUnallocatedBullionBalance:
            return "/bullion/rest/v1/unallocated-balance"

        case .buyBullion:
            return "/bullion/rest/v1/items/buy"

        case .sellBullion:
            return "/bullion/rest/v1/items/sell"

        case .getSpreadPercentage:
            return "/currency-exchange/rest/v1/currency-exchanges/spread-percentage"
            
        case .getInformationRequests:
            return "/transfer-aml-information/rest/v1/information-requests"
            
        case .uploadInformationRequestFile(let id, _):
            return "/transfer-aml-information/rest/v1/information-requests/\(id)/files"
            
        case .uploadInformationRequestAnswers(let id, _):
            return "/transfer-aml-information/rest/v1/information-requests/\(id)/answer"
            
        case .unblockPaymentCardCVV(let cardId):
            return "/issued-payment-card/v1/cards/\(cardId)/unblock-cvv"
            
        case .getIsAdditionalInformationNeeded(let transferID):
            return "/transfer-aml/rest/v1/details/\(transferID)/additional-info-needed"
            
        case .createTransferAmlDetailsDocument:
            return "transfer-aml/rest/v1/documents"
            
        case .uploadTransferAmlDetailsDocumentFile(let hash, _):
            return "transfer-aml/rest/v1/documents/\(hash)"
            
        case .uploadTransferAmlDetailsDocument:
            return "transfer-aml/rest/v1/details"
            
        case .uploadAdditionalTransferDetails(let transferID, let hash):
            return "transfer-aml/rest/v1/details/\(hash)/transfer/\(transferID)"
        }
    }
    
    private var parameters: Parameters? {
        switch self {
        case .get(_, let parameters),
             .post(_, let parameters),
             .put(_, let parameters),
             .delete(_, let parameters):
            return parameters
            
        case .getIbanInformation(_, let currency):
            guard let currency = currency else { return [:] }
            return ["currency": currency]
            
        case .getBalance( _, let showHistoricalCurrencies):
            return ["show_historical_currencies": showHistoricalCurrencies ? 1 : 0]
            
        case .getPaymentCardDeliveryDate(let country, let deliveryType):
            return ["country": country, "delivery_type": deliveryType]
        
        case .getPaymentCardDesigns(let filter):
            return filter.toJSON()

        case .getPaymentCardIssuePrice(let filter):
            return filter.toJSON()
            
        case .getPaymentCardDeliveryCountries(let filter):
            return filter.toJSON()
            
        case .getPaymentCards(let cardsFilter):
            return cardsFilter.toJSON()
            
        case .getCategorizedAccountNumbers(let filter):
            return filter.toJSON()
            
        case .getCardOrderRestrictions(let cardAccountOwnerId, let cardOwnerId):
            return [
                "card_account_owner_id": cardAccountOwnerId,
                "card_owner_id": cardOwnerId
            ]
            
        case .createCard(let psCard):
            return psCard.toJSON()
            
        case .setPaymentCardLimit(_, let cardLimit):
            return cardLimit.toJSON()
            
        case .retrievePaymentCardPIN( _, let cvv):
            return ["cvv2" :cvv]
            
        case .provisionCardForXPay(_, let request):
            return request.toJSON()

        case .setAccountDefaultDescription( _, let description):
            return ["description": description]
            
        case .setAccountDescription(let userId, _, let description):
            return ["body": ["description" : description], "query": ["user_id": userId]]
               
        case .getAuthorizations(let psGetAuthorizationsRequest):
            return psGetAuthorizationsRequest.toJSON()
            
        case .createAuthorization(let psCreateAuthorizationRequest):
            return psCreateAuthorizationRequest.toJSON()
        
        case .updateAuthorization( _, let psCreateAuthorizationRequest):
            return ["body": psCreateAuthorizationRequest.toJSON()]

        case .setPaymentCardDeliveryPreference(_, let preference):
            return preference.toJSON()
            
        case .getAvailableCurrencies(let filter):
            return filter.toJSON()
            
        case .validateAuthorizationUsers(let userIds):
            return ["user_ids": userIds]
            
        case .getConversionTransfers(let filter):
            return filter.toJSON()
            
        case .getBullionItems(let filter),
             .getUnallocatedBullionBalance(let filter):
            return filter.toJSON()

        case .getBullionOptions(let filter):
            return filter.toJSON()

        case .buyBullion(let identifier, let accountNumber):
            return [
                "account_number": accountNumber,
                "identifier": identifier
            ]

        case .sellBullion(let hash):
            return ["hash": hash]

        case .getSpreadPercentage(let request):
            return request.toJSON()
            
        case .getInformationRequests(let filter):
            return filter.toJSON()
            
        case .uploadInformationRequestFile(_, let file):
            return file.toJSON()
            
        case .uploadInformationRequestAnswers(_, let answers):
            return answers.toJSON()
            
        case .activateCard(_, let cvv):
            return ["cvv2": cvv]
            
        case .uploadTransferAmlDetailsDocumentFile(_, let file):
            return file.toJSON()
            
        case .uploadTransferAmlDetailsDocument(let information):
            return information.toJSON()
            
        default:
            return nil
        }
    }
}

extension AccountsApiRequestRouter: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let url = Self.baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.method = method
        
        switch self {
        case .setAccountDescription,
             .updateAuthorization:
            urlRequest = try CompositeEncoding.default.encode(urlRequest, with: parameters)
            
        case _ where method == .post,
             _ where method == .put:
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            
        default:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
