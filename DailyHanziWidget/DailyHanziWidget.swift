import WidgetKit
import SwiftUI

struct SimpleEntry: TimelineEntry {
    let date: Date
    let character: HanziCharacter?
}

struct Provider: TimelineProvider {
    
    private let suiteName = "group.com.dailyhanzi.app"
    
    private var defaults: UserDefaults {
        if let sharedDefaults = UserDefaults(suiteName: suiteName) {
            return sharedDefaults
        }
        return UserDefaults.standard
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        // Fallback default HSK 1 character
        let defaultChar = HanziCharacter(
            character: "学",
            pinyin: "xué",
            meaning: "to study; learn",
            hskLevel: 1,
            partOfSpeech: "Verb",
            exampleSentence: "我喜欢学中文。",
            exampleTranslation: "I like studying Chinese."
        )
        return SimpleEntry(date: Date(), character: defaultChar)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = placeholder(in: context)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        let now = Date()
        var entries: [SimpleEntry] = []
        
        // Read scheduled playlist from shared App Group UserDefaults
        if let data = defaults.data(forKey: "h_scheduled_playlist"),
           let decodedSchedule = try? JSONDecoder().decode([HanziManager.ScheduledCharacter].self, from: data) {
            
            // Generate entries for WidgetKit timeline
            // Filter out items scheduled in the past, but keep the current active one
            let futureOrActiveItems = decodedSchedule.filter { item in
                // Keep if it is active now or scheduled in the future
                let intervalMinutes = defaults.integer(forKey: "h_refresh_interval")
                let span = Double((intervalMinutes > 0 ? intervalMinutes : 60) * 60)
                return item.date.addingTimeInterval(span) >= now
            }
            
            for item in futureOrActiveItems {
                entries.append(SimpleEntry(date: item.date, character: item.character))
            }
        }
        
        // If the shared schedule is empty, fall back to our beautiful curated list
        if entries.isEmpty {
            let backupChar = HSKVocabulary.baseVocabulary.randomElement()
            entries.append(SimpleEntry(date: now, character: backupChar))
        }
        
        // Refresh the timeline when the pre-scheduled items finish
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

// MARK: - Widget Views

struct DailyHanziWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        if let char = entry.character {
            switch family {
            case .accessoryRectangular:
                // Lock Screen Large Rectangular Widget
                HStack(spacing: 8) {
                    Text(char.character)
                        .font(.system(size: 38, weight: .regular, design: .serif))
                        .minimumScaleFactor(0.8)
                    
                    VStack(alignment: .leading, spacing: 1) {
                        Text(char.pinyin)
                            .font(.system(size: 11, weight: .bold, design: .rounded))
                            .lineLimit(1)
                        
                        Text(char.meaning)
                            .font(.system(size: 10, weight: .medium, design: .rounded))
                            .lineLimit(2)
                            .opacity(0.8)
                        
                        Text("HSK \(char.hskLevel)")
                            .font(.system(size: 7, weight: .black, design: .rounded))
                            .opacity(0.5)
                    }
                    Spacer()
                }
                .padding(.horizontal, 4)
                
            case .accessoryInline:
                // Lock Screen Single Line Text Widget
                Text("\(char.character) [\(char.pinyin)]: \(char.meaning)")
                    .lineLimit(1)
                
            case .systemSmall:
                // Home Screen Small Widget (Glassmorphic look)
                VStack(spacing: 0) {
                    HStack {
                        Text("HSK \(char.hskLevel)")
                            .font(.system(size: 9, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(levelColor(char.hskLevel))
                            .cornerRadius(8)
                        
                        Spacer()
                        
                        Text(char.partOfSpeech)
                            .font(.system(size: 8, weight: .semibold, design: .rounded))
                            .foregroundColor(.white.opacity(0.3))
                    }
                    .padding([.top, .horizontal], 12)
                    
                    Spacer()
                    
                    Text(char.character)
                        .font(.system(size: 52, weight: .regular, design: .serif))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    VStack(spacing: 2) {
                        Text(char.pinyin)
                            .font(.system(size: 12, weight: .bold, design: .rounded))
                            .foregroundColor(Color(hex: "00F2FE"))
                        
                        Text(char.meaning)
                            .font(.system(size: 11, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.7))
                            .lineLimit(1)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.bottom, 12)
                    .padding(.horizontal, 8)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(hex: "0A0D14"))
                
            case .systemMedium:
                // Home Screen Medium Widget (Detailed card look)
                HStack(spacing: 16) {
                    VStack(spacing: 6) {
                        Text(char.character)
                            .font(.system(size: 64, weight: .regular, design: .serif))
                            .foregroundColor(.white)
                        
                        Text("HSK \(char.hskLevel)")
                            .font(.system(size: 9, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(levelColor(char.hskLevel))
                            .cornerRadius(8)
                    }
                    .frame(width: 100, maxHeight: .infinity)
                    .background(Color.white.opacity(0.03))
                    .cornerRadius(16)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text(char.pinyin)
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(Color(hex: "00F2FE"))
                            
                            Spacer()
                            
                            Text(char.partOfSpeech)
                                .font(.system(size: 10, weight: .semibold, design: .rounded))
                                .foregroundColor(.white.opacity(0.3))
                        }
                        
                        Text(char.meaning)
                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                            .lineLimit(1)
                        
                        Divider()
                            .background(Color.white.opacity(0.08))
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(char.exampleSentence)
                                .font(.system(size: 11, weight: .medium))
                                .foregroundColor(.white.opacity(0.85))
                                .lineLimit(1)
                            
                            Text(char.exampleTranslation)
                                .font(.system(size: 10, weight: .regular, design: .rounded))
                                .foregroundColor(.white.opacity(0.5))
                                .lineLimit(1)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(14)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(hex: "0A0D14"))
                
            default:
                Text(char.character)
            }
        } else {
            Text("Daily Hanzi")
        }
    }
    
    // Level Badge Colors
    private func levelColor(_ level: Int) -> Color {
        switch level {
        case 1: return Color(hex: "4FACFE")
        case 2: return Color(hex: "11998E")
        case 3: return Color(hex: "0072FF")
        case 4: return Color(hex: "FF4E50")
        case 5: return Color(hex: "FF5858")
        case 6: return Color(hex: "7F00FF")
        default: return Color.gray
        }
    }
}

// MARK: - Widget Bundle Definition

struct DailyHanziWidget: Widget {
    let kind: String = "DailyHanziWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            DailyHanziWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Daily Hanzi")
        .description("Random HSK Chinese character and meaning throughout the day.")
        .supportedFamilies([
            .accessoryRectangular,
            .accessoryInline,
            .systemSmall,
            .systemMedium
        ])
    }
}
