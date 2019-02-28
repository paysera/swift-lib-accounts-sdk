import Foundation
import XCTest
import PayseraAccountsSDK
import PromiseKit
import JWTDecode
import ObjectMapper

class AccountsSDKTests: XCTestCase {
    private var accountsApiClient: AccountsApiClient!
    private var token: String!
    
    override func setUp() {
        super.setUp()
        
        self.token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJldnBiYW5rIiwiaXNzIjoiYXV0aF9hcGkiLCJleHAiOjE1NTEzOTY3MTQsImp0aSI6IkRfQ0x3RTZyZGFEV0htcXM0X0paZ2hndm1NS3h5M3FEIiwicHNyOnMiOlsibG9nZ2VkX2luIiwiY29uZmlybWVkX2xvZ19pbiJdLCJwc3I6dSI6IjE3MDYxODYiLCJwc3I6c2lkIjoiMy1nRk1ISTFDQkxEeE1YUTRCbW1FQ3NDNnlRYXc4UVkiLCJwc3I6YSI6eyJ1c2VyX2lkIjoiMTcwNjE4NiJ9LCJpYXQiOjE1NTEzNTM1MTR9.aT42IlAZDUG4gUQOFRioHIHxmrZsmk4mUkm3SdvbQm3t6vJKr_l57mG3AR8eVOj4JFQFyZ1tqo2wtiiLsbw99RCu0j7COBA2cLFx_BF466otETkFAnZxz5Hm0S3tSnCHAq8LPDpAE5tLdkHqL4T3a4DnBE-5Y1ZnFsSsqNWtGEQdyXKTrLvSm51ZkWDHhlBhX8byjGXigIYGGYxOVQX4scB4EhJI9RmGtNNX9Rss8YpCciHhcaYwxRfk8hjCrxNuQeBowA7NW3ukCiUwrgrEeq5inASg5qx1qUDPVS5jWg8ZNLTPPb9e-Q4l5qEQe4bv9TC7L-wdHqXBo0l7S_Ivtu9joXwu0c0ECC8ISOmvmOAsuV_xSXHbI_H5Yni12J0Z-ax7MTVtdUz6MNht9gfIM6CWvK0QZ-54oasV2mc1inhPBoNEbZeaXT8VZ8PNZXXv3pfgqyNahy72UYIr0OV8sPOmqoLtztDEUodSvq9XRfXW-rFFmc96FWbgbPIhQrRZ_SJ2GrvZAO2V8NchZnU35Lhv28kLyHqH40x4uLD2agUFLQMGMYEyeJ9cHQNrRN3Na5DEZrwR5JsDAHJJGL6OtU1654zJX2Si72oid3-IeMQKRbMepXplS_q1HMWX9W7E82RRm396IUPtN3qtQpqW94Btek8PvyTle4w8jCaGdt4"
        
        self.accountsApiClient = createAccountsApiClient()
    }
    
    private func createAccountsApiClient() -> AccountsApiClient {
        let credentials = AccountsApiCredentials()
        credentials.token = try! decode(jwt: self.token)
        
        return AccountsApiClientFactory.createAccountsApiClient(credentials: credentials)
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
        
        accountsApiClient
            .getPaymentCardIssuePrice(country: "lt", clientType: "natural", cardOwnerId: "165660")
            .done { issuePrice in
                object = issuePrice
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
}
