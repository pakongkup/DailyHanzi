import SwiftUI

struct ContentView: View {
    @StateObject private var manager = HanziManager.shared
    
    // Animation/State controls
    @State private var isCardFlipped = false
    @State private var showingSettings = false
    
    // Gradients for HSK levels
    private func gradientForLevel(_ level: Int) -> LinearGradient {
        switch level {
        case 1:
            return LinearGradient(colors: [Color(hex: "00F2FE"), Color(hex: "4FACFE")], startPoint: .topLeading, endPoint: .bottomTrailing)
        case 2:
            return LinearGradient(colors: [Color(hex: "11998E"), Color(hex: "38EF7D")], startPoint: .topLeading, endPoint: .bottomTrailing)
        case 3:
            return LinearGradient(colors: [Color(hex: "00C6FF"), Color(hex: "0072FF")], startPoint: .topLeading, endPoint: .bottomTrailing)
        case 4:
            return LinearGradient(colors: [Color(hex: "F9D423"), Color(hex: "FF4E50")], startPoint: .topLeading, endPoint: .bottomTrailing)
        case 5:
            return LinearGradient(colors: [Color(hex: "F857A6"), Color(hex: "FF5858")], startPoint: .topLeading, endPoint: .bottomTrailing)
        case 6:
            return LinearGradient(colors: [Color(hex: "7F00FF"), Color(hex: "E100FF")], startPoint: .topLeading, endPoint: .bottomTrailing)
        default:
            return LinearGradient(colors: [.gray, .black], startPoint: .top, endPoint: .bottom)
        }
    }
    
    var body: some View {
        ZStack {
            // Elegant premium dark background
            Color(hex: "0A0D14")
                .ignoresSafeArea()
            
            // Dynamic colorful glowing background spots (glassmorphic ambient light)
            VStack {
                HStack {
                    Circle()
                        .fill(Color(hex: "00F2FE").opacity(0.15))
                        .frame(width: 250, height: 250)
                        .blur(radius: 60)
                    Spacer()
                }
                Spacer()
                HStack {
                    Spacer()
                    Circle()
                        .fill(Color(hex: "7F00FF").opacity(0.15))
                        .frame(width: 300, height: 300)
                        .blur(radius: 80)
                }
            }
            .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 24) {
                    
                    // Header
                    HStack {
                        VStack(align: .leading, spacing: 4) {
                            Text("DAILY HANZI")
                                .font(.system(size: 14, weight: .bold, design: .rounded))
                                .foregroundColor(Color(hex: "00F2FE"))
                                .tracking(3)
                            
                            Text("Today's Practice")
                                .font(.system(size: 28, weight: .heavy, design: .rounded))
                                .foregroundColor(.white)
                        }
                        Spacer()
                        
                        // Settings Trigger Button
                        Button {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                                showingSettings.toggle()
                            }
                        } label: {
                            Image(systemName: showingSettings ? "arrow.down.right.and.arrow.up.left" : "slider.horizontal.3")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(width: 44, height: 44)
                                .background(Color.white.opacity(0.08))
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Color.white.opacity(0.15), lineWidth: 1)
                                )
                        }
                    }
                    .padding(.top, 16)
                    
                    // Settings Panel (Collapsible)
                    if showingSettings {
                        settingsPanel
                            .transition(.asymmetric(
                                insertion: .opacity.combined(with: .scale(scale: 0.95)).combined(with: .offset(y: -20)),
                                removal: .opacity.combined(with: .scale(scale: 0.95)).combined(with: .offset(y: -20))
                            ))
                    }
                    
                    // Main Hero Calligraphy Card (Flippable)
                    if let active = manager.activeCharacter {
                        VStack(spacing: 20) {
                            ZStack {
                                // Front Card
                                cardFace(active.character)
                                    .opacity(isCardFlipped ? 0 : 1)
                                    .rotation3DEffect(
                                        .degrees(isCardFlipped ? 180 : 0),
                                        axis: (x: 0.0, y: 1.0, z: 0.0)
                                    )
                                
                                // Back Card (Details)
                                cardBack(active.character)
                                    .opacity(isCardFlipped ? 1 : 0)
                                    .rotation3DEffect(
                                        .degrees(isCardFlipped ? 0 : -180),
                                        axis: (x: 0.0, y: 1.0, z: 0.0)
                                    )
                            }
                            .onTapGesture {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                    isCardFlipped.toggle()
                                }
                            }
                            
                            // Card Controls
                            HStack(spacing: 16) {
                                // Next Button
                                Button {
                                    withAnimation(.spring()) {
                                        isCardFlipped = false
                                        manager.forceNextCharacter()
                                        triggerHaptic()
                                    }
                                } label: {
                                    HStack {
                                        Image(systemName: "forward.fill")
                                        Text("Next Word")
                                            .font(.system(size: 16, weight: .bold, design: .rounded))
                                    }
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 52)
                                    .background(Color.white.opacity(0.08))
                                    .cornerRadius(16)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16).stroke(Color.white.opacity(0.15), lineWidth: 1)
                                    )
                                }
                                
                                // Done/Learned Button
                                Button {
                                    withAnimation(.spring()) {
                                        manager.completedIds.insert(active.character.character)
                                        triggerSuccessHaptic()
                                    }
                                } label: {
                                    HStack {
                                        Image(systemName: manager.completedIds.contains(active.character.character) ? "checkmark.circle.fill" : "circle")
                                        Text("Learned")
                                            .font(.system(size: 16, weight: .bold, design: .rounded))
                                    }
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 52)
                                    .background(
                                        manager.completedIds.contains(active.character.character)
                                        ? Color(hex: "00F2FE")
                                        : Color.white
                                    )
                                    .cornerRadius(16)
                                    .shadow(color: manager.completedIds.contains(active.character.character) ? Color(hex: "00F2FE").opacity(0.4) : Color.white.opacity(0.2), radius: 10, y: 4)
                                }
                            }
                        }
                    } else {
                        // Empty State
                        emptyStateView
                    }
                    
                    // Daily Stats & Circular Progress Section
                    HStack(spacing: 20) {
                        // Circular Progress Card
                        VStack(spacing: 12) {
                            ZStack {
                                Circle()
                                    .stroke(Color.white.opacity(0.05), lineWidth: 10)
                                    .frame(width: 80, height: 80)
                                
                                Circle()
                                    .trim(from: 0.0, to: CGFloat(min(Double(manager.completedIds.count) / Double(max(manager.dailyCount, 1)), 1.0)))
                                    .stroke(
                                        LinearGradient(colors: [Color(hex: "00F2FE"), Color(hex: "7F00FF")], startPoint: .top, endPoint: .bottom),
                                        style: StrokeStyle(lineWidth: 10, lineCap: .round)
                                    )
                                    .frame(width: 80, height: 80)
                                    .rotationEffect(.degrees(-90))
                                    .animation(.easeInOut, value: manager.completedIds.count)
                                
                                Text("\(manager.completedIds.count)/\(manager.dailyCount)")
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                            }
                            
                            Text("Completion")
                                .font(.system(size: 13, weight: .medium, design: .rounded))
                                .foregroundColor(.white.opacity(0.6))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(20)
                        .background(Color.white.opacity(0.03))
                        .cornerRadius(24)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24).stroke(Color.white.opacity(0.08), lineWidth: 1)
                        )
                        
                        // Active Schedule Details
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "timer")
                                    .foregroundColor(Color(hex: "00F2FE"))
                                Text("Widget Timeline")
                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                            }
                            
                            Text("Refreshes every")
                                .font(.system(size: 12, weight: .medium, design: .rounded))
                                .foregroundColor(.white.opacity(0.4))
                            
                            Text("\(manager.refreshIntervalMinutes) min")
                                .font(.system(size: 20, weight: .black, design: .rounded))
                                .foregroundColor(.white)
                            
                            Text("Dynamic Widget active")
                                .font(.system(size: 11, weight: .regular, design: .rounded))
                                .foregroundColor(.white.opacity(0.3))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(20)
                        .background(Color.white.opacity(0.03))
                        .cornerRadius(24)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24).stroke(Color.white.opacity(0.08), lineWidth: 1)
                        )
                    }
                    
                    // Daily Playlist Queue
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Today's Playlist")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.horizontal, 4)
                        
                        VStack(spacing: 12) {
                            ForEach(manager.currentSchedule, id: \.self) { item in
                                playlistRow(item)
                            }
                        }
                    }
                    .padding(.bottom, 32)
                }
                .padding(.horizontal, 20)
            }
        }
    }
    
    // MARK: - Front Card Face
    private func cardFace(_ char: HanziCharacter) -> some View {
        VStack(spacing: 20) {
            HStack {
                Text("HSK \(char.hskLevel)")
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(gradientForLevel(char.hskLevel))
                    .cornerRadius(20)
                
                Spacer()
                
                Text(char.partOfSpeech)
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundColor(.white.opacity(0.4))
            }
            .padding(.horizontal, 8)
            
            Spacer()
            
            // Giant Calligraphy styled Character
            Text(char.character)
                .font(.system(size: 100, weight: .regular, design: .serif))
                .foregroundColor(.white)
                .shadow(color: .white.opacity(0.15), radius: 10)
            
            Spacer()
            
            VStack(spacing: 4) {
                Text("TAP TO REVEAL")
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .foregroundColor(Color(hex: "00F2FE").opacity(0.8))
                    .tracking(2)
            }
        }
        .padding(24)
        .frame(height: 320)
        .background(
            RoundedRectangle(cornerRadius: 32)
                .fill(Color.white.opacity(0.04))
                .background(VisualEffectBlur(material: .systemUltraThinMaterial, blendMode: .withinWindow))
        )
        .cornerRadius(32)
        .overlay(
            RoundedRectangle(cornerRadius: 32)
                .stroke(
                    LinearGradient(
                        colors: [Color.white.opacity(0.15), Color.white.opacity(0.02)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1.5
                )
        )
        .shadow(color: Color.black.opacity(0.3), radius: 20, y: 10)
    }
    
    // MARK: - Back Card Face
    private func cardBack(_ char: HanziCharacter) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("HSK \(char.hskLevel)")
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(gradientForLevel(char.hskLevel))
                    .cornerRadius(20)
                
                Spacer()
                
                Text("PINYIN & MEANING")
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .foregroundColor(Color(hex: "00F2FE"))
                    .tracking(1.5)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(char.pinyin)
                    .font(.system(size: 26, weight: .bold, design: .rounded))
                    .foregroundColor(Color(hex: "00F2FE"))
                
                Text(char.meaning)
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
                    .lineLimit(2)
            }
            .padding(.top, 8)
            
            Divider()
                .background(Color.white.opacity(0.1))
            
            VStack(alignment: .leading, spacing: 6) {
                Text("EXAMPLE SENTENCE")
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .foregroundColor(.white.opacity(0.4))
                    .tracking(1)
                
                Text(char.exampleSentence)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white.opacity(0.9))
                
                Text(char.exampleTranslation)
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundColor(.white.opacity(0.6))
            }
            
            Spacer()
        }
        .padding(28)
        .frame(height: 320)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 32)
                .fill(Color(hex: "0F1424").opacity(0.85))
                .background(VisualEffectBlur(material: .systemUltraThinMaterial, blendMode: .withinWindow))
        )
        .cornerRadius(32)
        .overlay(
            RoundedRectangle(cornerRadius: 32)
                .stroke(Color.white.opacity(0.15), lineWidth: 1.5)
        )
        .shadow(color: Color.black.opacity(0.4), radius: 20, y: 10)
    }
    
    // MARK: - Playlist Row UI
    private func playlistRow(_ item: HanziManager.ScheduledCharacter) -> some View {
        let isActive = manager.activeCharacter?.id == item.id
        let isCompleted = manager.completedIds.contains(item.character.character)
        
        return HStack(spacing: 16) {
            // Level badge
            Text(item.character.character)
                .font(.system(size: 24, weight: .semibold, design: .serif))
                .foregroundColor(.white)
                .frame(width: 48, height: 48)
                .background(
                    isCompleted
                    ? Color(hex: "00F2FE").opacity(0.1)
                    : Color.white.opacity(0.04)
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(
                            isActive ? Color(hex: "00F2FE") : Color.white.opacity(0.08),
                            lineWidth: isActive ? 2 : 1
                        )
                )
            
            VStack(align: .leading, spacing: 2) {
                HStack(spacing: 8) {
                    Text(item.character.pinyin)
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text("HSK \(item.character.hskLevel)")
                        .font(.system(size: 9, weight: .bold, design: .rounded))
                        .foregroundColor(.white.opacity(0.6))
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(gradientForLevel(item.character.hskLevel).opacity(0.3))
                        .cornerRadius(6)
                }
                
                Text(item.character.meaning)
                    .font(.system(size: 13, weight: .regular, design: .rounded))
                    .foregroundColor(.white.opacity(0.5))
                    .lineLimit(1)
            }
            
            Spacer()
            
            // Time Badge or Checked Badge
            VStack(alignment: .trailing, spacing: 4) {
                if isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(Color(hex: "00F2FE"))
                        .font(.system(size: 18))
                } else {
                    Text(formatTime(item.date))
                        .font(.system(size: 11, weight: .semibold, design: .rounded))
                        .foregroundColor(isActive ? Color(hex: "00F2FE") : .white.opacity(0.3))
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            isActive
            ? Color.white.opacity(0.05)
            : Color.white.opacity(0.01)
        )
        .cornerRadius(18)
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(isActive ? Color(hex: "00F2FE").opacity(0.3) : Color.clear, lineWidth: 1.5)
        )
    }
    
    // MARK: - Collapsible Settings Panel
    private var settingsPanel: some View {
        VStack(spacing: 20) {
            // HSK Selection
            VStack(alignment: .leading, spacing: 10) {
                Text("HSK DIFFICULTY LEVELS")
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .foregroundColor(Color(hex: "00F2FE"))
                    .tracking(2)
                
                HStack(spacing: 8) {
                    ForEach(1...6, id: \.self) { level in
                        Button {
                            triggerHaptic()
                            if manager.selectedLevels.contains(level) {
                                if manager.selectedLevels.count > 1 {
                                    manager.selectedLevels.remove(level)
                                }
                            } else {
                                manager.selectedLevels.insert(level)
                            }
                        } label: {
                            Text("\(level)")
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 38)
                                .background(
                                    manager.selectedLevels.contains(level)
                                    ? gradientForLevel(level)
                                    : LinearGradient(colors: [Color.white.opacity(0.04), Color.white.opacity(0.04)], startPoint: .top, endPoint: .bottom)
                                )
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(manager.selectedLevels.contains(level) ? Color.clear : Color.white.opacity(0.12), lineWidth: 1)
                                )
                        }
                    }
                }
            }
            
            Divider()
                .background(Color.white.opacity(0.08))
            
            // Customizable Sliders
            VStack(spacing: 16) {
                // Refresh frequency
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("REFRESH TIME INTERVAL")
                            .font(.system(size: 10, weight: .bold, design: .rounded))
                            .foregroundColor(.white.opacity(0.5))
                            .tracking(2)
                        Spacer()
                        Text("\(manager.refreshIntervalMinutes) minutes")
                            .font(.system(size: 13, weight: .bold, design: .rounded))
                            .foregroundColor(Color(hex: "00F2FE"))
                    }
                    
                    Slider(value: Binding(
                        get: { Double(manager.refreshIntervalMinutes) },
                        set: { manager.refreshIntervalMinutes = Int($0) }
                    ), in: 15...240, step: 15)
                    .accentColor(Color(hex: "00F2FE"))
                }
                
                // Words target size
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("DAILY WORD COUNT")
                            .font(.system(size: 10, weight: .bold, design: .rounded))
                            .foregroundColor(.white.opacity(0.5))
                            .tracking(2)
                        Spacer()
                        Text("\(manager.dailyCount) characters")
                            .font(.system(size: 13, weight: .bold, design: .rounded))
                            .foregroundColor(Color(hex: "00F2FE"))
                    }
                    
                    Slider(value: Binding(
                        get: { Double(manager.dailyCount) },
                        set: { manager.dailyCount = Int($0) }
                    ), in: 3...30, step: 1)
                    .accentColor(Color(hex: "00F2FE"))
                }
            }
        }
        .padding(20)
        .background(Color.white.opacity(0.03))
        .cornerRadius(24)
        .overlay(
            RoundedRectangle(cornerRadius: 24).stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
    }
    
    // MARK: - Utilities & Subviews
    
    private var emptyStateView: some View {
        VStack(spacing: 12) {
            Image(systemName: "square.dashed")
                .font(.system(size: 40))
                .foregroundColor(.white.opacity(0.2))
            
            Text("No Vocabulary Selected")
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundColor(.white.opacity(0.6))
            
            Text("Toggle HSK difficulty levels in configurations.")
                .font(.system(size: 13))
                .foregroundColor(.white.opacity(0.4))
                .multilineTextAlignment(.center)
        }
        .padding(40)
        .frame(height: 320)
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.02))
        .cornerRadius(32)
    }
    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    private func triggerHaptic() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    private func triggerSuccessHaptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

// MARK: - Helper Blur Effect for SwiftUI (Glassmorphism)
struct VisualEffectBlur: UIViewRepresentable {
    var material: UIBlurEffect.Material
    var blendMode: UIVisualEffectView.BackgroundBlendMode?
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: material))
        if let blendMode = blendMode {
            view.backgroundBlendMode = blendMode
        }
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: material)
    }
}

// MARK: - Color Hex Extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 1)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
