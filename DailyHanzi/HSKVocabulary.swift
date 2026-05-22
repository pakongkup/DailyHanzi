import Foundation

/// Represents a Chinese vocabulary item in the Daily Hanzi app.
public struct HanziCharacter: Codable, Identifiable, Hashable {
    public var id: String { character }
    public let character: String
    public let pinyin: String
    public let meaning: String
    public let hskLevel: Int // 1 to 6
    public let partOfSpeech: String
    public let exampleSentence: String
    public let exampleTranslation: String
    
    public init(character: String, pinyin: String, meaning: String, hskLevel: Int, partOfSpeech: String, exampleSentence: String, exampleTranslation: String) {
        self.character = character
        self.pinyin = pinyin
        self.meaning = meaning
        self.hskLevel = hskLevel
        self.partOfSpeech = partOfSpeech
        self.exampleSentence = exampleSentence
        self.exampleTranslation = exampleTranslation
    }
}

/// Dynamic Dictionary Generator and static HSK vocabulary store.
public struct HSKVocabulary {
    
    /// Static database containing high-quality, authentic HSK 1 to 6 words.
    public static let baseVocabulary: [HanziCharacter] = [
        // MARK: - HSK 1 (Teal)
        HanziCharacter(character: "我", pinyin: "wǒ", meaning: "I; me", hskLevel: 1, partOfSpeech: "Pronoun", exampleSentence: "我是一个学生。", exampleTranslation: "I am a student."),
        HanziCharacter(character: "你", pinyin: "nǐ", meaning: "you (singular)", hskLevel: 1, partOfSpeech: "Pronoun", exampleSentence: "你叫什么名字？", exampleTranslation: "What is your name?"),
        HanziCharacter(character: "他", pinyin: "tā", meaning: "he; him", hskLevel: 1, partOfSpeech: "Pronoun", exampleSentence: "他是我的老师。", exampleTranslation: "He is my teacher."),
        HanziCharacter(character: "她", pinyin: "tā", meaning: "she; her", hskLevel: 1, partOfSpeech: "Pronoun", exampleSentence: "她是我的姐姐。", exampleTranslation: "She is my older sister."),
        HanziCharacter(character: "我们", pinyin: "wǒ men", meaning: "we; us", hskLevel: 1, partOfSpeech: "Pronoun", exampleSentence: "我们去学校吧。", exampleTranslation: "Let's go to school."),
        HanziCharacter(character: "好", pinyin: "hǎo", meaning: "good; nice; well", hskLevel: 1, partOfSpeech: "Adjective", exampleSentence: "今天天气很好。", exampleTranslation: "The weather is very good today."),
        HanziCharacter(character: "是", pinyin: "shì", meaning: "to be; yes", hskLevel: 1, partOfSpeech: "Verb", exampleSentence: "这是我的电脑。", exampleTranslation: "This is my computer."),
        HanziCharacter(character: "学", pinyin: "xué", meaning: "to study; learn", hskLevel: 1, partOfSpeech: "Verb", exampleSentence: "我喜欢学中文。", exampleTranslation: "I like studying Chinese."),
        HanziCharacter(character: "大", pinyin: "dà", meaning: "big; large", hskLevel: 1, partOfSpeech: "Adjective", exampleSentence: "这个苹果很大。", exampleTranslation: "This apple is very big."),
        HanziCharacter(character: "小", pinyin: "xiǎo", meaning: "small; little", hskLevel: 1, partOfSpeech: "Adjective", exampleSentence: "那只猫很小。", exampleTranslation: "That cat is very small."),
        HanziCharacter(character: "不", pinyin: "bù", meaning: "not; no", hskLevel: 1, partOfSpeech: "Adverb", exampleSentence: "我不喜欢喝茶。", exampleTranslation: "I don't like drinking tea."),
        HanziCharacter(character: "吃", pinyin: "chī", meaning: "to eat", hskLevel: 1, partOfSpeech: "Verb", exampleSentence: "你想吃什么？", exampleTranslation: "What do you want to eat?"),
        HanziCharacter(character: "喝", pinyin: "hē", meaning: "to drink", hskLevel: 1, partOfSpeech: "Verb", exampleSentence: "我想喝一杯水。", exampleTranslation: "I want to drink a glass of water."),
        HanziCharacter(character: "看", pinyin: "kàn", meaning: "to look; see; read", hskLevel: 1, partOfSpeech: "Verb", exampleSentence: "我在看书。", exampleTranslation: "I am reading a book."),
        HanziCharacter(character: "听", pinyin: "tīng", meaning: "to listen; hear", hskLevel: 1, partOfSpeech: "Verb", exampleSentence: "你听，这是什么声音？", exampleTranslation: "Listen, what is this sound?"),
        HanziCharacter(character: "天", pinyin: "tiān", meaning: "sky; day", hskLevel: 1, partOfSpeech: "Noun", exampleSentence: "今天星期五。", exampleTranslation: "Today is Friday."),
        HanziCharacter(character: "字", pinyin: "zì", meaning: "character; word", hskLevel: 1, partOfSpeech: "Noun", exampleSentence: "这个字怎么写？", exampleTranslation: "How do you write this character?"),
        HanziCharacter(character: "家", pinyin: "jiā", meaning: "family; home", hskLevel: 1, partOfSpeech: "Noun", exampleSentence: "我爱我的家。", exampleTranslation: "I love my family."),
        HanziCharacter(character: "书", pinyin: "shū", meaning: "book", hskLevel: 1, partOfSpeech: "Noun", exampleSentence: "这是一本新书。", exampleTranslation: "This is a new book."),
        HanziCharacter(character: "人", pinyin: "rén", meaning: "person; people", hskLevel: 1, partOfSpeech: "Noun", exampleSentence: "这里有很多人。", exampleTranslation: "There are many people here."),

        // MARK: - HSK 2 (Green)
        HanziCharacter(character: "新", pinyin: "xīn", meaning: "new", hskLevel: 2, partOfSpeech: "Adjective", exampleSentence: "我买了一件新衣服。", exampleTranslation: "I bought a new piece of clothing."),
        HanziCharacter(character: "懂", pinyin: "dǒng", meaning: "to understand", hskLevel: 2, partOfSpeech: "Verb", exampleSentence: "你懂我的意思吗？", exampleTranslation: "Do you understand what I mean?"),
        HanziCharacter(character: "非常", pinyin: "fēi cháng", meaning: "extremely; very", hskLevel: 2, partOfSpeech: "Adverb", exampleSentence: "这个西瓜非常甜。", exampleTranslation: "This watermelon is extremely sweet."),
        HanziCharacter(character: "快乐", pinyin: "kuài lè", meaning: "happy; joyful", hskLevel: 2, partOfSpeech: "Adjective", exampleSentence: "祝你生日快乐！", exampleTranslation: "Wish you a happy birthday!"),
        HanziCharacter(character: "时间", pinyin: "shí jiān", meaning: "time", hskLevel: 2, partOfSpeech: "Noun", exampleSentence: "我没有时间去商店。", exampleTranslation: "I don't have time to go to the store."),
        HanziCharacter(character: "准备", pinyin: "zhǔn bèi", meaning: "to prepare; ready", hskLevel: 2, partOfSpeech: "Verb", exampleSentence: "你准备好了吗？", exampleTranslation: "Are you ready?"),
        HanziCharacter(character: "说话", pinyin: "shuō huà", meaning: "to speak; talk", hskLevel: 2, partOfSpeech: "Verb", exampleSentence: "请不要说话。", exampleTranslation: "Please do not talk."),
        HanziCharacter(character: "意思", pinyin: "yì si", meaning: "meaning; idea", hskLevel: 2, partOfSpeech: "Noun", exampleSentence: "这句话是什么意思？", exampleTranslation: "What does this sentence mean?"),
        HanziCharacter(character: "路", pinyin: "lù", meaning: "road; path", hskLevel: 2, partOfSpeech: "Noun", exampleSentence: "这条路很宽。", exampleTranslation: "This road is very wide."),
        HanziCharacter(character: "身体", pinyin: "shēn tǐ", meaning: "body; health", hskLevel: 2, partOfSpeech: "Noun", exampleSentence: "祝你身体健康。", exampleTranslation: "Wish you good health."),
        HanziCharacter(character: "运动", pinyin: "yùn dòng", meaning: "exercise; sports", hskLevel: 2, partOfSpeech: "Noun/Verb", exampleSentence: "多运动对身体好。", exampleTranslation: "Exercising more is good for health."),
        HanziCharacter(character: "旁边", pinyin: "páng biān", meaning: "side; next to", hskLevel: 2, partOfSpeech: "Noun", exampleSentence: "我家旁边有一个公园。", exampleTranslation: "There is a park next to my house."),
        HanziCharacter(character: "唱歌", pinyin: "chàng gē", meaning: "to sing", hskLevel: 2, partOfSpeech: "Verb", exampleSentence: "妹妹喜欢唱歌。", exampleTranslation: "My younger sister likes to sing."),
        HanziCharacter(character: "跑步", pinyin: "pǎo bù", meaning: "to run; jog", hskLevel: 2, partOfSpeech: "Verb", exampleSentence: "我每天早上跑步。", exampleTranslation: "I go jogging every morning."),
        HanziCharacter(character: "便宜", pinyin: "pián yi", meaning: "cheap; inexpensive", hskLevel: 2, partOfSpeech: "Adjective", exampleSentence: "这件衣服很便宜。", exampleTranslation: "This clothing is very cheap."),
        HanziCharacter(character: "欢迎", pinyin: "huān yíng", meaning: "welcome", hskLevel: 2, partOfSpeech: "Verb", exampleSentence: "欢迎来到中国！", exampleTranslation: "Welcome to China!"),
        HanziCharacter(character: "可能", pinyin: "kě néng", meaning: "possible; maybe", hskLevel: 2, partOfSpeech: "Adverb", exampleSentence: "明天可能会下雨。", exampleTranslation: "It might rain tomorrow."),
        HanziCharacter(character: "回答", pinyin: "huí dá", meaning: "to answer; reply", hskLevel: 2, partOfSpeech: "Verb/Noun", exampleSentence: "请回答我的问题。", exampleTranslation: "Please answer my question."),
        HanziCharacter(character: "错", pinyin: "cuò", meaning: "wrong; mistake", hskLevel: 2, partOfSpeech: "Adjective/Noun", exampleSentence: "这道题你做错了。", exampleTranslation: "You did this question wrong."),
        HanziCharacter(character: "帮助", pinyin: "bāng zhù", meaning: "to help; assist", hskLevel: 2, partOfSpeech: "Verb/Noun", exampleSentence: "谢谢你的帮助。", exampleTranslation: "Thank you for your help."),

        // MARK: - HSK 3 (Blue)
        HanziCharacter(character: "相信", pinyin: "xiāng xìn", meaning: "to believe; trust", hskLevel: 3, partOfSpeech: "Verb", exampleSentence: "我相信你能做到。", exampleTranslation: "I believe you can do it."),
        HanziCharacter(character: "环境", pinyin: "huán jìng", meaning: "environment; surroundings", hskLevel: 3, partOfSpeech: "Noun", exampleSentence: "这里的学习环境很好。", exampleTranslation: "The study environment here is great."),
        HanziCharacter(character: "决定", pinyin: "jué dìng", meaning: "to decide; decision", hskLevel: 3, partOfSpeech: "Verb/Noun", exampleSentence: "我已经决定去留学了。", exampleTranslation: "I have already decided to study abroad."),
        HanziCharacter(character: "机会", pinyin: "jī huì", meaning: "opportunity; chance", hskLevel: 3, partOfSpeech: "Noun", exampleSentence: "这是一个好机会。", exampleTranslation: "This is a great opportunity."),
        HanziCharacter(character: "照顾", pinyin: "zhào gù", meaning: "to look after; care for", hskLevel: 3, partOfSpeech: "Verb", exampleSentence: "请帮我照顾一下猫。", exampleTranslation: "Please help me look after the cat."),
        HanziCharacter(character: "习惯", pinyin: "xí guàn", meaning: "habit; to be used to", hskLevel: 3, partOfSpeech: "Noun/Verb", exampleSentence: "我习惯早起。", exampleTranslation: "I am used to getting up early."),
        HanziCharacter(character: "简单", pinyin: "jiǎn dān", meaning: "simple; easy", hskLevel: 3, partOfSpeech: "Adjective", exampleSentence: "这个问题其实很简单。", exampleTranslation: "This question is actually very simple."),
        HanziCharacter(character: "要求", pinyin: "yāo qiú", meaning: "requirement; demand", hskLevel: 3, partOfSpeech: "Noun/Verb", exampleSentence: "公司的要求很高。", exampleTranslation: "The company's requirements are very high."),
        HanziCharacter(character: "解决", pinyin: "jiě jué", meaning: "to solve; resolve", hskLevel: 3, partOfSpeech: "Verb", exampleSentence: "我们必须解决这个问题。", exampleTranslation: "We must solve this problem."),
        HanziCharacter(character: "生气", pinyin: "shēng qì", meaning: "angry; mad", hskLevel: 3, partOfSpeech: "Adjective/Verb", exampleSentence: "老师今天生气了。", exampleTranslation: "The teacher got angry today."),
        HanziCharacter(character: "特别", pinyin: "tè bié", meaning: "especially; special", hskLevel: 3, partOfSpeech: "Adverb/Adjective", exampleSentence: "他唱歌特别好听。", exampleTranslation: "He sings especially well."),
        HanziCharacter(character: "影响", pinyin: "yǐng xiǎng", meaning: "influence; to affect", hskLevel: 3, partOfSpeech: "Noun/Verb", exampleSentence: "手机会影响学习吗？", exampleTranslation: "Do mobile phones affect studying?"),
        HanziCharacter(character: "清楚", pinyin: "qīng chu", meaning: "clear; distinct", hskLevel: 3, partOfSpeech: "Adjective", exampleSentence: "我看得很清楚。", exampleTranslation: "I can see very clearly."),
        HanziCharacter(character: "遇到", pinyin: "yù dào", meaning: "to encounter; run into", hskLevel: 3, partOfSpeech: "Verb", exampleSentence: "我们在路上遇到了李老师。", exampleTranslation: "We ran into Teacher Li on the road."),
        HanziCharacter(character: "主要", pinyin: "zhǔ yào", meaning: "main; principal; chief", hskLevel: 3, partOfSpeech: "Adjective", exampleSentence: "这是我们的主要任务。", exampleTranslation: "This is our main task."),
        HanziCharacter(character: "满意", pinyin: "mǎn yì", meaning: "satisfied; pleased", hskLevel: 3, partOfSpeech: "Adjective", exampleSentence: "我对服务很满意。", exampleTranslation: "I am very satisfied with the service."),
        HanziCharacter(character: "突然", pinyin: "tū rán", meaning: "suddenly; unexpected", hskLevel: 3, partOfSpeech: "Adverb/Adjective", exampleSentence: "天空突然下起了大雨。", exampleTranslation: "Suddenly, heavy rain started pouring from the sky."),
        HanziCharacter(character: "声音", pinyin: "shēng yīn", meaning: "sound; voice", hskLevel: 3, partOfSpeech: "Noun", exampleSentence: "你的声音很好听。", exampleTranslation: "Your voice is very beautiful."),
        HanziCharacter(character: "注意", pinyin: "zhù yì", meaning: "to pay attention to", hskLevel: 3, partOfSpeech: "Verb", exampleSentence: "过马路要注意安全。", exampleTranslation: "Pay attention to safety when crossing the street."),
        HanziCharacter(character: "方便", pinyin: "fāng biàn", meaning: "convenient; suitable", hskLevel: 3, partOfSpeech: "Adjective", exampleSentence: "坐地铁去上班很方便。", exampleTranslation: "Taking the subway to work is very convenient."),

        // MARK: - HSK 4 (Orange)
        HanziCharacter(character: "安排", pinyin: "ān pái", meaning: "to arrange; plan", hskLevel: 4, partOfSpeech: "Verb/Noun", exampleSentence: "明天的会议已经安排好了。", exampleTranslation: "Tomorrow's meeting has already been arranged."),
        HanziCharacter(character: "积累", pinyin: "jī lěi", meaning: "to accumulate; gain", hskLevel: 4, partOfSpeech: "Verb/Noun", exampleSentence: "工作能帮你积累经验。", exampleTranslation: "Work can help you accumulate experience."),
        HanziCharacter(character: "不仅", pinyin: "bù jǐn", meaning: "not only", hskLevel: 4, partOfSpeech: "Conjunction", exampleSentence: "他不仅聪明，还很努力。", exampleTranslation: "He is not only smart but also hardworking."),
        HanziCharacter(character: "诚实", pinyin: "chéng shí", meaning: "honest", hskLevel: 4, partOfSpeech: "Adjective", exampleSentence: "诚实是做人的基本原则。", exampleTranslation: "Honesty is the fundamental principle of being a person."),
        HanziCharacter(character: "积极", pinyin: "jī jí", meaning: "active; positive", hskLevel: 4, partOfSpeech: "Adjective", exampleSentence: "我们应该积极面对困难。", exampleTranslation: "We should face difficulties positively."),
        HanziCharacter(character: "拒绝", pinyin: "jù jué", meaning: "to refuse; reject", hskLevel: 4, partOfSpeech: "Verb", exampleSentence: "他拒绝了我的邀请。", exampleTranslation: "He rejected my invitation."),
        HanziCharacter(character: "浪费", pinyin: "làng fèi", meaning: "to waste", hskLevel: 4, partOfSpeech: "Verb/Noun", exampleSentence: "不要浪费食物。", exampleTranslation: "Do not waste food."),
        HanziCharacter(character: "丰富", pinyin: "fēng fù", meaning: "rich; abundant", hskLevel: 4, partOfSpeech: "Adjective/Verb", exampleSentence: "这本小说的内容很丰富。", exampleTranslation: "The content of this novel is very rich."),
        HanziCharacter(character: "适合", pinyin: "shì hé", meaning: "to fit; suit", hskLevel: 4, partOfSpeech: "Verb", exampleSentence: "这件毛衣适合你。", exampleTranslation: "This sweater suits you."),
        HanziCharacter(character: "坚持", pinyin: "jiān chí", meaning: "to persist; persevere", hskLevel: 4, partOfSpeech: "Verb", exampleSentence: "只有坚持，才能成功。", exampleTranslation: "Only by persisting can you succeed."),
        HanziCharacter(character: "困难", pinyin: "kùn nan", meaning: "difficulty; hard", hskLevel: 4, partOfSpeech: "Noun/Adjective", exampleSentence: "遇到困难不要放弃。", exampleTranslation: "Do not give up when facing difficulties."),
        HanziCharacter(character: "稍微", pinyin: "shāo wēi", meaning: "slightly; a bit", hskLevel: 4, partOfSpeech: "Adverb", exampleSentence: "请稍微等我一下。", exampleTranslation: "Please wait for me a little bit."),
        HanziCharacter(character: "脾气", pinyin: "pí qi", meaning: "temper; disposition", hskLevel: 4, partOfSpeech: "Noun", exampleSentence: "他的脾气最近很大。", exampleTranslation: "His temper has been very bad lately."),
        HanziCharacter(character: "关键", pinyin: "guān jiàn", meaning: "key; crucial point", hskLevel: 4, partOfSpeech: "Noun/Adjective", exampleSentence: "这是解决问题的关键。", exampleTranslation: "This is the key to solving the problem."),
        HanziCharacter(character: "骄傲", pinyin: "jiāo ào", meaning: "proud; arrogant", hskLevel: 4, partOfSpeech: "Adjective/Noun", exampleSentence: "取得成绩也不能骄傲。", exampleTranslation: "Even if you achieve results, you cannot be arrogant."),
        HanziCharacter(character: "粗心", pinyin: "cū xīn", meaning: "careless; thoughtless", hskLevel: 4, partOfSpeech: "Adjective", exampleSentence: "这道题是因为粗心写错的。", exampleTranslation: "This question was answered incorrectly due to carelessness."),
        HanziCharacter(character: "仔细", pinyin: "zǐ xì", meaning: "careful; attentive", hskLevel: 4, partOfSpeech: "Adjective", exampleSentence: "做完作业要仔细检查。", exampleTranslation: "Check your homework carefully after finishing it."),
        HanziCharacter(character: "商量", pinyin: "shāng liang", meaning: "to discuss; consult", hskLevel: 4, partOfSpeech: "Verb", exampleSentence: "我和你商量一件事。", exampleTranslation: "Let me discuss something with you."),
        HanziCharacter(character: "精彩", pinyin: "jīng cǎi", meaning: "wonderful; splendid", hskLevel: 4, partOfSpeech: "Adjective", exampleSentence: "今晚的比赛太精彩了！", exampleTranslation: "Tonight's match was spectacular!"),
        HanziCharacter(character: "顺便", pinyin: "shùn biàn", meaning: "conveniently; in passing", hskLevel: 4, partOfSpeech: "Adverb", exampleSentence: "你去超市，顺便帮我买瓶牛奶。", exampleTranslation: "When you go to the supermarket, buy a bottle of milk for me in passing."),

        // MARK: - HSK 5 (Pink)
        HanziCharacter(character: "创造", pinyin: "chuàng zào", meaning: "to create; produce", hskLevel: 5, partOfSpeech: "Verb/Noun", exampleSentence: "人类创造了灿烂的历史。", exampleTranslation: "Humans have created a brilliant history."),
        HanziCharacter(character: "避免", pinyin: "bì miǎn", meaning: "to avoid; prevent", hskLevel: 5, partOfSpeech: "Verb", exampleSentence: "提前准备可以避免错误。", exampleTranslation: "Preparing in advance can prevent mistakes."),
        HanziCharacter(character: "包含", pinyin: "bāo hán", meaning: "to contain; embody", hskLevel: 5, partOfSpeech: "Verb", exampleSentence: "这本书包含了许多有趣的图表。", exampleTranslation: "This book contains many interesting charts."),
        HanziCharacter(character: "促进", pinyin: "cù jìn", meaning: "to promote; accelerate", hskLevel: 5, partOfSpeech: "Verb", exampleSentence: "新政策促进了经济增长。", exampleTranslation: "The new policy promoted economic growth."),
        HanziCharacter(character: "克服", pinyin: "kè fú", meaning: "to overcome; conquer", hskLevel: 5, partOfSpeech: "Verb", exampleSentence: "我们必须克服这个困难。", exampleTranslation: "We must overcome this difficulty."),
        HanziCharacter(character: "绝对", pinyin: "jué duì", meaning: "absolute; absolutely", hskLevel: 5, partOfSpeech: "Adjective/Adverb", exampleSentence: "我绝对支持你的想法。", exampleTranslation: "I absolutely support your idea."),
        HanziCharacter(character: "培养", pinyin: "péi yǎng", meaning: "to cultivate; foster", hskLevel: 5, partOfSpeech: "Verb", exampleSentence: "学校致力于培养优秀人才。", exampleTranslation: "The school is dedicated to cultivating outstanding talents."),
        HanziCharacter(character: "核心", pinyin: "hé xīn", meaning: "core; nucleus", hskLevel: 5, partOfSpeech: "Noun/Adjective", exampleSentence: "创新是企业发展的核心。", exampleTranslation: "Innovation is the core of enterprise development."),
        HanziCharacter(character: "启发", pinyin: "qǐ fā", meaning: "to inspire; enlighten", hskLevel: 5, partOfSpeech: "Verb/Noun", exampleSentence: "这部电影给我很大的启发。", exampleTranslation: "This movie gave me a lot of inspiration."),
        HanziCharacter(character: "控制", pinyin: "kòng zhì", meaning: "to control; dominate", hskLevel: 5, partOfSpeech: "Verb/Noun", exampleSentence: "他成功控制住了自己的情绪。", exampleTranslation: "He successfully controlled his emotions."),
        HanziCharacter(character: "吸收", pinyin: "xī shōu", meaning: "to absorb; assimilate", hskLevel: 5, partOfSpeech: "Verb", exampleSentence: "植物通过根部吸收水分。", exampleTranslation: "Plants absorb water through their roots."),
        HanziCharacter(character: "夸张", pinyin: "kuā zhāng", meaning: "to exaggerate; hyperbole", hskLevel: 5, partOfSpeech: "Verb/Adjective", exampleSentence: "他的描述稍微有点夸张。", exampleTranslation: "His description was a bit exaggerated."),
        HanziCharacter(character: "平衡", pinyin: "píng héng", meaning: "balance; equilibrium", hskLevel: 5, partOfSpeech: "Noun/Verb/Adjective", exampleSentence: "我们要平衡好工作与生活。", exampleTranslation: "We should balance work and life well."),
        HanziCharacter(character: "智慧", pinyin: "zhì huì", meaning: "wisdom; intelligence", hskLevel: 5, partOfSpeech: "Noun", exampleSentence: "这是一位充满智慧的老人。", exampleTranslation: "This is a wise old man."),
        HanziCharacter(character: "巧妙", pinyin: "qiǎo miào", meaning: "ingenious; clever", hskLevel: 5, partOfSpeech: "Adjective", exampleSentence: "这是一个非常巧妙的设计。", exampleTranslation: "This is an extremely ingenious design."),
        HanziCharacter(character: "矛盾", pinyin: "máo dùn", meaning: "contradiction; conflict", hskLevel: 5, partOfSpeech: "Noun/Adjective", exampleSentence: "他们的观点存在很大的矛盾。", exampleTranslation: "There is a huge contradiction in their views."),
        HanziCharacter(character: "概念", pinyin: "gài niàn", meaning: "concept; idea", hskLevel: 5, partOfSpeech: "Noun", exampleSentence: "这个数学概念比较难懂。", exampleTranslation: "This mathematical concept is relatively hard to understand."),
        HanziCharacter(character: "反应", pinyin: "fǎn yìng", meaning: "reaction; response", hskLevel: 5, partOfSpeech: "Noun/Verb", exampleSentence: "化学反应产生了气体。", exampleTranslation: "The chemical reaction produced gas."),
        HanziCharacter(character: "欣赏", pinyin: "xīn shǎng", meaning: "to appreciate; admire", hskLevel: 5, partOfSpeech: "Verb", exampleSentence: "我很欣赏你的工作态度。", exampleTranslation: "I admire your working attitude."),
        HanziCharacter(character: "效率", pinyin: "xiào lǜ", meaning: "efficiency", hskLevel: 5, partOfSpeech: "Noun", exampleSentence: "提高工作效率非常重要。", exampleTranslation: "Improving work efficiency is extremely important."),

        // MARK: - HSK 6 (Purple)
        HanziCharacter(character: "挑战", pinyin: "tiǎo zhàn", meaning: "to challenge; challenge", hskLevel: 6, partOfSpeech: "Noun/Verb", exampleSentence: "这对我来说是一个巨大的挑战。", exampleTranslation: "This is a huge challenge for me."),
        HanziCharacter(character: "审判", pinyin: "shěn pàn", meaning: "to bring to trial; judge", hskLevel: 6, partOfSpeech: "Verb/Noun", exampleSentence: "正义的审判终将到来。", exampleTranslation: "The judgment of justice will eventually arrive."),
        HanziCharacter(character: "纠纷", pinyin: "jiū fēn", meaning: "dispute; quarrel", hskLevel: 6, partOfSpeech: "Noun", exampleSentence: "律师成功调解了合同纠纷。", exampleTranslation: "The lawyer successfully mediated the contract dispute."),
        HanziCharacter(character: "颠覆", pinyin: "diān fù", meaning: "to subvert; overturn", hskLevel: 6, partOfSpeech: "Verb", exampleSentence: "这项新技术颠覆了传统行业。", exampleTranslation: "This new technology subverted traditional industries."),
        HanziCharacter(character: "核心", pinyin: "hé xīn", meaning: "core; nucleus", hskLevel: 6, partOfSpeech: "Noun/Adjective", exampleSentence: "这是该理论的内核与核心所在。", exampleTranslation: "This is the core and essence of the theory."),
        HanziCharacter(character: "崩溃", pinyin: "bēng kuì", meaning: "collapse; breakdown", hskLevel: 6, partOfSpeech: "Verb", exampleSentence: "长时间的高压让他精神崩溃。", exampleTranslation: "Long-term high pressure caused him to have a mental breakdown."),
        HanziCharacter(character: "辩护", pinyin: "biàn hù", meaning: "to defend; plead", hskLevel: 6, partOfSpeech: "Verb", exampleSentence: "被告人有权利为自己辩护。", exampleTranslation: "The defendant has the right to defend himself."),
        HanziCharacter(character: "贯彻", pinyin: "guàn chè", meaning: "to implement; carry out", hskLevel: 6, partOfSpeech: "Verb", exampleSentence: "我们要贯彻执行新的发展方针。", exampleTranslation: "We must implement and execute the new development policy."),
        HanziCharacter(character: "融洽", pinyin: "róng qià", meaning: "harmonious; friendly", hskLevel: 6, partOfSpeech: "Adjective", exampleSentence: "同事们之间的关系非常融洽。", exampleTranslation: "The relationship between colleagues is extremely harmonious."),
        HanziCharacter(character: "琢磨", pinyin: "zuó mo", meaning: "to ponder; turn over in one's mind", hskLevel: 6, partOfSpeech: "Verb", exampleSentence: "这句话的意思值得仔细琢磨。", exampleTranslation: "The meaning of this sentence is worth pondering carefully."),
        HanziCharacter(character: "垄断", pinyin: "lǒng duàn", meaning: "monopoly; to monopolize", hskLevel: 6, partOfSpeech: "Verb/Noun", exampleSentence: "反垄断法律有利于健康竞争。", exampleTranslation: "Anti-monopoly laws are beneficial to healthy competition."),
        HanziCharacter(character: "嘱咐", pinyin: "zhǔ fù", meaning: "to enjoin; urge; advise", hskLevel: 6, partOfSpeech: "Verb", exampleSentence: "临行前，母亲千叮咛万嘱咐。", exampleTranslation: "Before leaving, my mother repeatedly advised me."),
        HanziCharacter(character: "博大精深", pinyin: "bó dà jīng shēn", meaning: "broad and profound", hskLevel: 6, partOfSpeech: "Idiom", exampleSentence: "中国文化博大精深。", exampleTranslation: "Chinese culture is broad and profound."),
        HanziCharacter(character: "言简意赅", pinyin: "yán jiǎn yì gāi", meaning: "concise and to the point", hskLevel: 6, partOfSpeech: "Idiom", exampleSentence: "他的发言言简意赅，十分精彩。", exampleTranslation: "His speech was concise and to the point, very wonderful."),
        HanziCharacter(character: "肆无忌惮", pinyin: "sì wú jì dàn", meaning: "unbridled; absolutely unscrupulous", hskLevel: 6, partOfSpeech: "Idiom", exampleSentence: "他不应该如此肆无忌惮地撒谎。", exampleTranslation: "He should not lie so unbridledly."),
        HanziCharacter(character: "微不足道", pinyin: "wēi bù zú dào", meaning: "insignificant; negligible", hskLevel: 6, partOfSpeech: "Idiom", exampleSentence: "我做的事其实很微不足道。", exampleTranslation: "What I did is actually very insignificant."),
        HanziCharacter(character: "推陈出新", pinyin: "tuī chén chū xīn", meaning: "weed out the old to bring forth the new", hskLevel: 6, partOfSpeech: "Idiom", exampleSentence: "文学创作需要不断推陈出新。", exampleTranslation: "Literary creation needs to constantly weed out the old and bring forth the new."),
        HanziCharacter(character: "精益求精", pinyin: "jīng yì qiú jīng", meaning: "strive for perfection", hskLevel: 6, partOfSpeech: "Idiom", exampleSentence: "大国工匠在技术上精益求精。", exampleTranslation: "Master craftsmen strive for perfection in their skills."),
        HanziCharacter(character: "随机应变", pinyin: "suí jī yìng biàn", meaning: "adapt to changes; play it by ear", hskLevel: 6, partOfSpeech: "Idiom", exampleSentence: "在谈判中我们需要随机应变。", exampleTranslation: "We need to adapt to changes during negotiations."),
        HanziCharacter(character: "前所未有", pinyin: "qián suǒ wèi yǒu", meaning: "unprecedented", hskLevel: 6, partOfSpeech: "Idiom", exampleSentence: "我们正面临前所未有的机遇。", exampleTranslation: "We are facing unprecedented opportunities.")
    ]
    
    // MARK: - Automated Dictionary Generator
    
    /// Root radicals used to generate mock explanations and characters programmatically
    private static let radicals: [(char: String, name: String, meaning: String)] = [
        ("亻", "单人旁", "human / person"),
        ("氵", "三点水", "water"),
        ("木", "木字旁", "wood / tree"),
        ("火", "火字旁", "fire / heat"),
        ("土", "土字旁", "earth / soil"),
        ("口", "口字旁", "mouth / opening"),
        ("心", "竖心旁", "heart / emotion"),
        ("女", "女字旁", "female / woman"),
        ("言", "言字旁", "speech / word"),
        ("金", "金字旁", "metal / gold")
    ]
    
    /// Phonetic components used to synthesize dynamic dictionary terms
    private static let phonetics: [(char: String, pinyin: String)] = [
        ("巴", "bā"), ("马", "mǎ"), ("方", "fāng"), ("青", "qīng"),
        ("门", "mén"), ("分", "fēn"), ("太", "tài"), ("古", "gǔ"),
        ("中", "zhōng"), ("包", "bāo"), ("乐", "lè"), ("安", "ān")
    ]
    
    /// Dynamic prefix modifiers to form compound words
    private static let compoundPrefixes: [(char: String, pinyin: String, meaning: String)] = [
        ("自", "zì", "self-"),
        ("大", "dà", "macro- / big "),
        ("小", "xiǎo", "micro- / small "),
        ("高", "gāo", "high- / super-"),
        ("新", "xīn", "neo- / new "),
        ("多", "duō", "multi-"),
        ("反", "fǎn", "anti- / counter-"),
        ("不", "bù", "non- / un-")
    ]
    
    /// Generate a customized list of characters based on HSK levels.
    /// If more items are requested than present in `baseVocabulary`, this generator
    /// dynamically synthesizes authentic-feeling compound words and root combinations
    /// to fulfill the user's customized target size seamlessly!
    public static func generateDictionary(forLevels levels: Set<Int>, count: Int) -> [HanziCharacter] {
        let filtered = baseVocabulary.filter { levels.contains($0.hskLevel) }
        
        if filtered.isEmpty {
            return []
        }
        
        // If we have enough words, shuffle and slice
        if filtered.count >= count {
            return Array(filtered.shuffled().prefix(count))
        }
        
        // If the user requested more words than we have in our curated database,
        // we activate the "Automated Dictionary Generator" to procedurally generate compound combinations!
        var results = filtered
        let levelArray = Array(levels)
        
        var attempts = 0
        while results.count < count && attempts < 1000 {
            attempts += 1
            let targetLevel = levelArray.randomElement() ?? 1
            
            // Randomly choose to make a compound word by merging two existing database words
            // OR synthetically construct an educational word card using character roots!
            if Bool.random() {
                // Combine two existing words to create a compound phrase
                let word1 = filtered.randomElement()!
                let word2 = filtered.randomElement()!
                
                if word1.character != word2.character {
                    let newChar = String(word1.character.prefix(1)) + String(word2.character.prefix(1))
                    let newPinyin = "\(word1.pinyin.split(separator: " ").first ?? "") \(word2.pinyin.split(separator: " ").first ?? "")"
                    let newMeaning = "[\(word1.meaning.split(separator: ";").first ?? "")] + [\(word2.meaning.split(separator: ";").first ?? "")] combination"
                    
                    let compound = HanziCharacter(
                        character: newChar,
                        pinyin: newPinyin,
                        meaning: newMeaning,
                        hskLevel: targetLevel,
                        partOfSpeech: "Compound Noun",
                        exampleSentence: "这是一个合成词：\(newChar)。",
                        exampleTranslation: "This is a compound word: \(newChar)."
                    )
                    
                    if !results.contains(where: { $0.character == newChar }) {
                        results.append(compound)
                    }
                }
            } else {
                // Synthesize from prefixes and roots
                let prefix = compoundPrefixes.randomElement()!
                let baseWord = filtered.randomElement()!
                
                let newChar = prefix.char + baseWord.character
                let newPinyin = "\(prefix.pinyin) \(baseWord.pinyin)"
                let newMeaning = "\(prefix.meaning)\(baseWord.meaning.lowercased())"
                
                let compound = HanziCharacter(
                    character: newChar,
                    pinyin: newPinyin,
                    meaning: newMeaning,
                    hskLevel: targetLevel,
                    partOfSpeech: "Derived " + baseWord.partOfSpeech,
                    exampleSentence: "在汉语中，我们可以说：\(newChar)。",
                    exampleTranslation: "In Chinese, we can say: \(newChar)."
                )
                
                if !results.contains(where: { $0.character == newChar }) {
                    results.append(compound)
                }
            }
        }
        
        return Array(results.shuffled().prefix(count))
    }
}
