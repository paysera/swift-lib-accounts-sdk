import Foundation
import XCTest
import PayseraAccountsSDK
import PayseraCommonSDK
import PromiseKit
import JWTDecode
import ObjectMapper

class AccountsSDKTests: XCTestCase {
    private var accountsApiClient: AccountsApiClient!
    
    override func setUp() {
        super.setUp()
        
        let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJldnBiYW5rIiwiaXNzIjoiYXV0aF9hcGkiLCJleHAiOjE1ODYyODUzMzEsImp0aSI6ImllLVF2YW9HdEtWYkVBTFBzZmstc01tYWp6Rjd3aGFPIiwicHNyOnMiOlsibG9nZ2VkX2luIiwiY29uZmlybWVkX2xvZ19pbiJdLCJwc3I6dSI6Ijk2NDg5OTQiLCJwc3I6c2lkIjoieU8xbTNTR1ZMUHRFUkZWNFFFSThzVnJLaWFicjIxQnkiLCJwc3I6YSI6eyJ1c2VyX2lkIjoiOTY0ODk5NCJ9LCJpYXQiOjE1ODYyNDIxMzF9.qiWReLIozen3pXltoCUyrW73QQMKmylqcafniZaTbxu0Pr_O4goJeFkDYHch-yhA497JWOltUe98pRHPJYH2se-Unn3Pv2buCt-bWYWK7fBTihjJ3i6vix46ZEv0AI5j6q0-0M-wE903mjRdRU30ZaI8VQ5eiL4s5K3nLR3lHF5iQcK4XAdg8YP_MG_eZe7vzQTRdkcoKbPnXzV7DxDXRdyh0g16uHX4ASxV-FgnneBsod3OkONmNMuPChr85jhgM79AL9QaAECPMwqBSzRFr6o0sHqdeT_nKO6lRFQruTVU_JV3yz9CsTlgn1lJi3qiFvuyaYB5spyuz0CNzbTsctcR7q68zSpLu2tgjEtayHs8oa5HSbqSxpNeos4zzsIaTwZNSKvXoSDLAl-KIM8dxToO5KjakNDyEQCNrkkouVfSqCoOHTosVWXHI8YimIMSixycxhIkIpTf4WuMv7m0Oe-vGOmuNcCAY4HBLFcrTXXc8cSUYr86WfTsy2Mjphsjz5oP6gqETIkP3VEXmwif8wIy3tNDkCbmy53H5QyjgIaaK-htmZsqLwalglxt4W2jWx4Rg9e5FRwHySShazQ5dF-y7kaX3llreC9Xpy-hWJpypAoImSKUfgbCrfDlNqaVKo3aYLgdnagKJTzPyD3DVb7SbIC1AOoSEP3H7IbwBag"
        
        let credentials = PSApiJWTCredentials()
        credentials.token = try! decode(jwt: token)
        
        accountsApiClient = AccountsApiClientFactory.createAccountsApiClient(credentials: credentials)
    }
    
    func testGetPurposeCodes() {
        var actual: PSPurposeCodeCollection?
        let expectation = XCTestExpectation(description: "Purpose codes field must exist")
        
        accountsApiClient
            .getPurposeCodes()
            .done { actual = $0 }
            .catch { print($0) }
            .finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(actual)
    }
    
    func testGetAvailableCurrencies() {
       var object: PSMetadataAwareResponse<PSAvailableCurrency>?
       let expectation = XCTestExpectation(description: "")
       
       let filter = PSAvailableCurrencyFilter()
       filter.userId = 165660
       accountsApiClient
           .getAvailableCurrencies(filter: filter)
           .done { result in
               object = result
           }.catch { error in
               print(error)
           }.finally { expectation.fulfill() }
       
       wait(for: [expectation], timeout: 3.0)
       XCTAssertNotNil(object)
    }
    
    func testGetPaymentCardDesigns() {
        var object: PSMetadataAwareResponse<PSPaymentCardDesign>?
        let expectation = XCTestExpectation(description: "")
        
        let filter = PSPaymentCardDesignFilter()
        filter.accountOwnerId = 165660
        accountsApiClient
            .getPaymentCardDesigns(filter: filter)
            .done { designs in
                object = designs
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testGetIbanInformation() {
        var object: PSIbanInformation?
        let expectation = XCTestExpectation(description: "")
        
        accountsApiClient
            .getIbanInformation(iban: "LT383500010001845744")
            .done { ibanInfo in
                object = ibanInfo
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testGetIbanInformationForTarget2Participant() {
        var object: PSIbanInformation?
        let expectation = XCTestExpectation(description: "")
        
        accountsApiClient
            .getIbanInformation(iban: "TR220011100000000073417181")
            .done { ibanInfo in
                object = ibanInfo
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertTrue((object?.target2Participant ?? false), "IbanInformation must be a target2Participant")
    }
    
    func testGetPaymentCardShippingAddress() {
        var object: PSPaymentCardShippingAddress?
        let expectation = XCTestExpectation(description: "")
        
        accountsApiClient
            .getPaymentCardShippingAddress(accountNumber: "EVP3710004041407")
            .done { shippingAddress in
                object = shippingAddress
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testGetPaymentCardDeliveryPrices() {
        var object: [PSPaymentCardDeliveryPrice]?
        let expectation = XCTestExpectation(description: "")
        
        accountsApiClient
            .getPaymentCardDeliveryPrices(country: "de")
            .done { deliveryPrices in
                object = deliveryPrices
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testGetPaymentCardDeliveryDate() {
        var object: PSPaymentCardDeliveryDate?
        let expectation = XCTestExpectation(description: "")
        
        accountsApiClient
            .getPaymentCardDeliveryDate(country: "de", deliveryType: "regular")
            .done { deliveryDate in
                object = deliveryDate
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testGetPaymentCardIssuePrice() {
        var object: PSPaymentCardIssuePrice?
        let expectation = XCTestExpectation(description: "")
        
        let filter = PSPaymentCardIssuePriceFilter()
        filter.cardAccountOwnerId = "6720691"
        filter.cardOwnerId = "6720691"
        
        accountsApiClient
            .getPaymentCardIssuePrice(filter: filter)
            .done { issuePrice in
                object = issuePrice
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testGetPaymentCardDeliveryCountries() {
        var object: PSPaymentCardDeliveryCountries?
        let expectation = XCTestExpectation(description: "")
        
        let filter = PSBaseFilter()
        filter.limit = 200
        
        accountsApiClient
            .getPaymentCardDeliveryCountries(filter: filter)
            .done { response in
                object = response
                
                print(object)
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testCreateAccount() {
        let expectation = XCTestExpectation(description: "")
        var object: Any?
        //insert user id
        accountsApiClient.createAccount(userId: 111111).done { result in
            object = result
            }.catch { error in
                print(error)
        }.finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testSetAccountDescription() {
        let expectation = XCTestExpectation(description: "")
        var object: Any?
        //insert user id and account number
        accountsApiClient.setAccountDescription(userId: 111111,
                                                accountNumber: "change me",
                                                description: "modric").done { result in
                                                    object = result
            }.catch { error in
                print(error)
            }.finally {
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testCanUserOrderCard() {
        let expectation = XCTestExpectation(description: "")
        var object: Any?
        //insert user id
        accountsApiClient.canUserOrderCard(userId: 1111111).done { result in
            object = result
            }.catch { error in
                print(error)
            }.finally {
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testCanUserFillQuestionnaire() {
        let expectation = XCTestExpectation(description: "")
        var object: Any?
        //insert user id
        accountsApiClient.canUserFillQuestionnaire(userId: 1111111).done { result in
            object = result
            }.catch { error in
                print(error)
            }.finally {
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testGetAuthorizations() {
        let expectation = XCTestExpectation(description: "")
        var object: Any?
        //insert accountNumbers
        let fitler = PSGetAuthorizationsFilterRequest(accountNumbers: [""])
        accountsApiClient.getAuthorizations(filter: fitler).done { result in
            object = result
            print(result.items)
            }.catch { error in
                print(error)
            }.finally {
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testCreateAuthorizations() {
        let expectation = XCTestExpectation(description: "")
        var object: Any?
        let authorization = PSCreateAuthorizationRequest(accountNumber: "", userIds: [""])
        authorization.readPermission = true
        accountsApiClient.createAuthorization(authorization: authorization).done { result in
            object = result
            print(result)
            }.catch { error in
                print(error)
            }.finally {
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testDeleteAuthorization() {
        let expectation = XCTestExpectation(description: "")
        var object: Any?
        accountsApiClient.deleteAuthorization(id: "insert authorization id").done { result in
            object = result
            print(result)
            }.catch { error in
                print(error)
            }.finally {
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testUpdateAuthorization() {
        let expectation = XCTestExpectation(description: "")
        var object: Any?
      
        let authorization = PSCreateAuthorizationRequest(accountNumber: "", userIds: [""])
        accountsApiClient
            .updateAuthorization(id: "insert authorization id", authorization: authorization)
            .done { result in
                object = result
                print(result)
            }.catch { error in
                print(error)
            }.finally {
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testGetPaymentCardDeliveryPreference() {
        var object: PSPaymentCardDeliveryPreference?
        let expectation = XCTestExpectation(description: "")
        
        accountsApiClient
            .getPaymentCardDeliveryPreference(accountNumber: "EVP9410007208697")
            .done { deliveryPreference in
                object = deliveryPreference
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testGetPaymentCardExpiringCardOrderRestriction() {
        var object: PSPaymentCardExpiringCardOrderRestriction?
        let expectation = XCTestExpectation(description: "")
        
        accountsApiClient
            .getPaymentPaymentCardExpiringCardOrderRestriction(accountNumber: "EVP3710004041407")
            .done { r in
                object = r
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testSetPaymentCardDeliveryPreference() {
        
        var object: Any?
        let expectation = XCTestExpectation(description: "")
        
        let preference = PSPaymentCardDeliveryPreference()
        preference.ownerId = 9007334
        preference.shippingAddress = PSPaymentCardShippingAddress(postalCode: "08426", address: "address", city: "Vilnius", country: "lt")
        preference.deliveryType = "regular"
        
        accountsApiClient
            .setPaymentCardDeliveryPreference(accountNumber: "EVP9410007208697",
                                              preference: preference
        )
            .done { result in
                object = result
        }.catch { error in
            print(error)
        }.finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testDeleteUserFromAuthorization() {
        let expectation = XCTestExpectation(description: "")
        var object: Any?
        accountsApiClient.deleteUserFromAuthorization(authorizationId: "insert_auth_id", userId: "0").done { result in
            object = result
        }.catch { error in
            print(error)
        }.finally {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
}
