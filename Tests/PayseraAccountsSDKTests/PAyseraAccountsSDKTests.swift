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
        
        let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJldnBiYW5rIiwiaXNzIjoiYXV0aF9hcGkiLCJleHAiOjE1ODE5NzUwNTcsImp0aSI6Ik0xWmYzWmxvc2xVdGRRV0h4U1dtQ3NzanVjaUs2aUlyIiwicHNyOnMiOlsibG9nZ2VkX2luIiwiY29uZmlybWVkX2xvZ19pbiJdLCJwc3I6dSI6IjY3MjA2OTEiLCJwc3I6c2lkIjoiaDhqeHY1eU5oQkRvVVIxalpiVGVFb0h3Q3ZzV29lZXkiLCJwc3I6YSI6eyJ1c2VyX2lkIjoiNjcyMDY5MSJ9LCJpYXQiOjE1ODE5MzE4NTd9.eFJp5E-FEEdO75CSC9gm2Nu_e1nDjAo3MYmL0ltM2ss7qQXYPPOFXPi8t_C3O1tX2Lz9FnmPfsT3XDEwkAWz-4k-ABxx_8mS4zLhT45ujrTsLZPlT2bwLUli8lUR_IYjbCtsE-ZkC9MMTAHa85hGZdpZi9isJb0tphXwc_BJVTVFnI1YtjpLt_eFeIl-BE-yz0aagODuCDyYnxVgrR19pGy4FmKvni9CfmT7vxYPJwpy-hUX60o6Co8ZvxynnDl1wP5M3fIwKPbE_YIfSD4x-Za7VT2EE-znH__ssUgqbTCNsM9w1K19RFEu3zTYl4QyAAmsi24RfxMf0MDdsFrHPAsNtbGoUDZnAD-nUpcuckr1-JytQlY3IFyP8owgwFk4qUGmN4gjwn9QiS9h52UsMTC6QvUpLaGUJFM6KpXDHjvkecVkalE4SFswMJhigLePXmJuXod8LPwUA4iv4eJrrb-dMzi-b3i2ca9feyrIsOozR0Egprasu5kmMqKnbjf2LmwIoloEw04Yfi0h4l_wx7WeheMFcdTrmmb6eRLJ9ON7a2NRRSIpXSBK3BHjhJBLNqISaybjijs0CM-J8-21IwpOVLLqjcUOU5uXlcvuE2Z-Z069MUppC-nbzvjx0CI9rLkGx71Gm7aDGiBdjd-WEgINgX6QHmqoe7RASWcMZyQ"
        
        let credentials = PSApiJWTCredentials()
        credentials.token = try! decode(jwt: token)
        
        accountsApiClient = AccountsApiClientFactory.createAccountsApiClient(credentials: credentials)
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
        filter.cardAccountOwnerId = 6720691
        filter.cardOwnerId = 6720691
        
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
}
