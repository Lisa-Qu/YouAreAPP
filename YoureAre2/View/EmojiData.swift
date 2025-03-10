//
//  EmojiData.swift
//  YoureAre2
//
//  Created by Lisa. Qu on 2025/2/21.
//
import Foundation

struct EmojiData {
    static let allEmojis: [String] = [
        // Smileys & People
        "😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "😊", "😇", "🙂", "🙃", "😉", "😌",
        "😍", "🥰", "😘", "😗", "😙", "😚", "😋", "😛", "😜", "🤪", "😝", "🤑", "🤗", "🤭",
        "🤫", "🤔", "🤐", "🤨", "😐", "😑", "😶", "😏", "😬", "🤥",  "😔",
        "😪", "🤤", "😴", "😷", "🤒", "🤕", "🤧",  "🤯", "🤠", "🥳", "🥸",
        "😎", "🤓", "🧐", "😕", "😟", "🙁", "☹️", "😮", "😯", "😲", "😳", "🥺", "😦", "😧",
        "😨", "😰", "😥", "😢", "😭", "😖", "😣", "😞", "😓", "😩", "😫", "🥱", "😤", "😡",
        "😠", "😈", "👿", "💀", "☠️", "💩", "🤡", "👹", "👺", "👻", "👽", "👾", "🤖",
        "😺", "😸", "😹", "😻", "😼", "😽", "🙀", "😿", "😾",
        
        // Hands & Gestures
        "👋", "🤚", "🖐️", "✋", "🖖", "👌", "🤌", "🤏", "✌️", "🤞", "🤟", "🤘", "🤙", "👈",
        "👉", "👆", "👇", "☝️", "👍", "👎", "✊", "👊", "🤛", "🤜", "👏", "🙌", "👐", "🤲",
        "🤝", "🙏", "💪", "🦾", "🖕",
        
        // People & Activities
        "🧑", "👩", "👨", "👵", "🧓", "👴", "👶", "🧒", "👧", "👦", "🧑‍🎓", "👩‍🎓", "👨‍🎓",
        "🧑‍🏫", "👩‍🏫", "👨‍🏫", "🧑‍⚕️", "👩‍⚕️", "👨‍⚕️", "🧑‍🚀", "👩‍🚀", "👨‍🚀", "🧑‍✈️",
        "👩‍✈️", "👨‍✈️", "👷", "👮", "🕵️", "💂", "🥷", "🤵", "👰", "🧕", "🤰", "🤱", "👼",
        "🎅", "🦸", "🦹",
        
        // LGBTQ+ Related Emojis
        "🏳️‍🌈", "🏳️‍⚧️", "👩‍❤️‍👩", "👨‍❤️‍👨", "👩‍❤️‍👨", "👩‍❤️‍💋‍👩", "👨‍❤️‍💋‍👨", "👩‍❤️‍💋‍👨", "🧑‍🤝‍🧑", "👬", "👭", "👫",

        
        // Travel & Places
        "🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚜", "🛵",
        "🚲", "🛴", "🛶", "🚤", "⛵", "🛳️", "🚀", "🛸", "🚁", "✈️", "🛩️", "🏰", "🗽", "🗼",
        "🏯", "🏟️", "🎡", "🎢", "🎠", "🏖️", "🏝️",
        
        // Objects & Symbols
        "⌚", "📱", "💻", "📷", "🎥", "📺", "📻", "🔊", "🎼", "🎸", "🎺", "🎻", "🎹", "🥁",
        "📚", "📖", "🔬", "🛠️",
        
        
        // Balls & Sports
        "⚽", "🏀", "🏈", "⚾","🎯",  "🎾", "🏐", "🏉", "🥏", "🎱", "🏓", "🏸", "🏒", "🏑", "🥍", "🏏", "🥎",

        // Animals & Nature
        "🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐽",
        "🐸", "🐵", "🙈", "🙉", "🙊", "🐒", "🐔", "🐧", "🐦", "🐤", "🐣", "🐥", "🦆", "🦅",

        // Food & Drink
        "🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭",
        "🍍", "🥥", "🥝", "🍅", "🥑", "🍆", "🥔", "🥕", "🌽", "🌶️", "🥒", "🥬", "🥦",
        "🧄", "🧅", "🍄", "🥜", "🌰", "🍞", "🥐", "🥖", "🥨", "🥯", "🧀", "🥚", "🍳",
        "🥓", "🥩", "🍗", "🍖", "🌭", "🍔", "🍟", "🍕", "🥪", "🥙", "🌮", "🌯", "🥗",
        "🥘", "🥫", "🍝", "🍜", "🍲", "🍛", "🍣", "🍤", "🥟", "🥠", "🥡", "🍦", "🍧",
        "🍨", "🍩", "🍪", "🎂", "🍰", "🧁", "🥧", "🍫", "🍬", "🍭", "🍮", "🍯", "🍼",
        "🥛", "☕", "🍵", "🍶", "🍾", "🍷", "🍸", "🍹", "🍺", "🍻", "🥂", "🥃", "🥤",
        "🧃", "🧉", "🧊"
    ]
}
