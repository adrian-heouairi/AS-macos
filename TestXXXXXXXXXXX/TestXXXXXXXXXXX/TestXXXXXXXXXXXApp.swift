import SwiftUI

@main
struct TestXXXXXXXXXXXApp: App {
    let manager = DataManager(preview: false)
    
    var body: some Scene {
        WindowGroup {
            TitleScreenView(manager: manager)
        }
    }
}
