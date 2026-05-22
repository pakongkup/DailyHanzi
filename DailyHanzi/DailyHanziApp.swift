import SwiftUI

@main
struct DailyHanziApp: App {
    // Force initialize the HanziManager singleton early
    init() {
        HanziManager.shared.regeneratePlaylistIfNeeded(force: false)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
