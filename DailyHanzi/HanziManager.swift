import Foundation
import WidgetKit
import Combine

/// Engine responsible for scheduling, configuration, and data coordination.
public class HanziManager: ObservableObject {
    
    public static let shared = HanziManager()
    
    // UserDefaults Suite Name for the shared App Group.
    // If Apple Developer Portal App Group is not configured, it falls back to standard UserDefaults.
    private let suiteName = "group.com.dailyhanzi.app"
    private var defaults: UserDefaults {
        if let sharedDefaults = UserDefaults(suiteName: suiteName) {
            return sharedDefaults
        }
        return UserDefaults.standard
    }
    
    // MARK: - Keys
    private let kSelectedLevels = "h_selected_levels"
    private let kRefreshInterval = "h_refresh_interval"
    private let kDailyCount = "h_daily_count"
    private let kScheduledPlaylist = "h_scheduled_playlist"
    private let kCompletedIds = "h_completed_ids"
    private let kLastGenerationDate = "h_last_generation_date"
    
    // MARK: - Published Config
    @Published public var selectedLevels: Set<Int> = [1, 2] {
        didSet {
            saveLevels()
            regeneratePlaylistIfNeeded(force: true)
        }
    }
    
    @Published public var refreshIntervalMinutes: Int = 60 {
        didSet {
            saveInterval()
            regeneratePlaylistIfNeeded(force: true)
        }
    }
    
    @Published public var dailyCount: Int = 10 {
        didSet {
            saveDailyCount()
            regeneratePlaylistIfNeeded(force: true)
        }
    }
    
    /// The computed schedule of characters with specific target appearance times
    @Published public var currentSchedule: [ScheduledCharacter] = []
    
    /// List of character IDs that the user has interacted with/completed today
    @Published public var completedIds: Set<String> = [] {
        didSet {
            saveCompletedIds()
        }
    }
    
    private init() {
        loadSettings()
        regeneratePlaylistIfNeeded(force: false)
    }
    
    // MARK: - Core Logic
    
    /// Scheduled representation of a character at a specific date
    public struct ScheduledCharacter: Codable, Identifiable, Hashable {
        public var id: String { character.character + "_\(date.timeIntervalSince1970)" }
        public let character: HanziCharacter
        public let date: Date
    }
    
    /// Returns the active scheduled character for the current date/time
    public var activeCharacter: ScheduledCharacter? {
        let now = Date()
        // Find the scheduled item that fits the current time window
        // i.e., the one with the closest start date in the past
        let pastItems = currentSchedule.filter { $0.date <= now }
        return pastItems.sorted(by: { $0.date > $1.date }).first ?? currentSchedule.first
    }
    
    /// Loads settings from shared suite
    private func loadSettings() {
        if let levelsArray = defaults.array(forKey: kSelectedLevels) as? [Int] {
            selectedLevels = Set(levelsArray)
        }
        
        let interval = defaults.integer(forKey: kRefreshInterval)
        refreshIntervalMinutes = interval > 0 ? interval : 60
        
        let count = defaults.integer(forKey: kDailyCount)
        dailyCount = count > 0 ? count : 10
        
        if let completed = defaults.stringArray(forKey: kCompletedIds) {
            completedIds = Set(completed)
        }
        
        loadSchedule()
    }
    
    private func saveLevels() {
        defaults.set(Array(selectedLevels), forKey: kSelectedLevels)
    }
    
    private func saveInterval() {
        defaults.set(refreshIntervalMinutes, forKey: kRefreshInterval)
    }
    
    private func saveDailyCount() {
        defaults.set(dailyCount, forKey: kDailyCount)
    }
    
    private func saveCompletedIds() {
        defaults.set(Array(completedIds), forKey: kCompletedIds)
    }
    
    /// Load schedule from shared container
    private func loadSchedule() {
        if let data = defaults.data(forKey: kScheduledPlaylist),
           let decoded = try? JSONDecoder().decode([ScheduledCharacter].self, from: data) {
            currentSchedule = decoded
        }
    }
    
    /// Regenerates today's playlist if it is a new day or if configurations changed
    public func regeneratePlaylistIfNeeded(force: Bool = false) {
        let now = Date()
        let calendar = Calendar.current
        
        let lastGen = defaults.object(forKey: kLastGenerationDate) as? Date ?? Date.distantPast
        let isNewDay = !calendar.isDate(now, inSameDayAs: lastGen)
        
        if force || isNewDay || currentSchedule.isEmpty {
            // Clear yesterday's progress if it's a new day
            if isNewDay {
                completedIds.removeAll()
            }
            
            // Generate standard random selection matching the requested settings
            let characters = HSKVocabulary.generateDictionary(forLevels: selectedLevels, count: dailyCount)
            
            // Layout a future schedule starting from now
            var newSchedule: [ScheduledCharacter] = []
            let intervalSecs = Double(refreshIntervalMinutes * 60)
            
            for (index, char) in characters.enumerated() {
                let scheduledDate = now.addingTimeInterval(Double(index) * intervalSecs)
                newSchedule.append(ScheduledCharacter(character: char, date: scheduledDate))
            }
            
            currentSchedule = newSchedule
            
            // Save to defaults
            if let encoded = try? JSONEncoder().encode(newSchedule) {
                defaults.set(encoded, forKey: kScheduledPlaylist)
            }
            defaults.set(now, forKey: kLastGenerationDate)
            
            // Trigger Widget Reload
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
    
    /// Forces a shift to next character immediately (advances schedule dates)
    public func forceNextCharacter() {
        guard !currentSchedule.isEmpty else { return }
        
        let now = Date()
        var updatedSchedule: [ScheduledCharacter] = []
        let intervalSecs = Double(refreshIntervalMinutes * 60)
        
        // Mark current as completed before cycling
        if let active = activeCharacter {
            completedIds.insert(active.character.character)
        }
        
        // Rearrange schedule so next word starts *now*
        // Find indices
        if let activeIdx = currentSchedule.firstIndex(where: { $0.id == activeCharacter?.id }) {
            let nextIdx = (activeIdx + 1) % currentSchedule.count
            
            for i in 0..<currentSchedule.count {
                let lookupIdx = (nextIdx + i) % currentSchedule.count
                let targetChar = currentSchedule[lookupIdx].character
                let scheduledDate = now.addingTimeInterval(Double(i) * intervalSecs)
                updatedSchedule.append(ScheduledCharacter(character: targetChar, date: scheduledDate))
            }
            
            currentSchedule = updatedSchedule
            
            if let encoded = try? JSONEncoder().encode(updatedSchedule) {
                defaults.set(encoded, forKey: kScheduledPlaylist)
            }
            
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
}
