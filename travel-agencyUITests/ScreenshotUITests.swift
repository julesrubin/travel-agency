
import XCTest

final class ScreenshotUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testCaptureTripDetails() throws {
        let app = XCUIApplication()
        app.launch()

        // 1. Tap "Travel" tab
        let travelTab = app.tabBars.buttons["Travel"]
        XCTAssertTrue(travelTab.waitForExistence(timeout: 5), "Travel tab not found")
        travelTab.tap()
        
        // 2. Wait for list to load and tap the first trip (e.g., Paris)
        // We look for a static text that is likely a destination
        let parisText = app.staticTexts["Paris"]
        if parisText.waitForExistence(timeout: 5) {
            parisText.tap()
        } else {
            // Fallback: tap the first button in the scroll view
            let firstButton = app.scrollViews.buttons.firstMatch
            if firstButton.waitForExistence(timeout: 5) {
                firstButton.tap()
            }
        }
        
        // 3. Wait for details to appear
        let bookButton = app.buttons["Book"]
        XCTAssertTrue(bookButton.waitForExistence(timeout: 5), "Book button not found")
        
        // 4. Take screenshot and save to /tmp
        let screenshot = XCUIScreen.main.screenshot()
        let data = screenshot.pngRepresentation
        do {
            try data.write(to: URL(fileURLWithPath: "/tmp/trip_details_final.png"))
            print("Screenshot saved to /tmp/trip_details_final.png")
        } catch {
            print("Failed to save screenshot: \(error)")
        }
        
        sleep(2)
    }
}
