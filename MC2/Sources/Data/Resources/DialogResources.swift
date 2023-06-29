//
//  DialogResources.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 24/06/23.
//

import SpriteKit

struct Dialog {
    let name: String?
    let prompt: String
    
    init(_ name: String?, prompt: String) {
        self.name = name
        self.prompt = prompt
    }
}

struct DialogResources {
    
    // MARK: Opening Scene
    static let opening_1_solo_seq1 = Dialog(Constants.mainCharacterName, prompt: "Where am I? I feel a bit dizzy.")
    static let opening_1_solo_seq2 = Dialog(Constants.mainCharacterName, prompt: "Where is this? It looks so strange...")
    static let opening_2_officeDesk_alt1 = Dialog(Constants.mainCharacterName, prompt: "Oh! My family photo. It was a great night.")
    static let opening_3_officeDesk_alt2 = Dialog(Constants.mainCharacterName, prompt: "Sigh… There are still a lot of work to do.")
    static let opening_4_photoAlbum_alt1 = Dialog(Constants.mainCharacterName, prompt: "A collection of photos with my friends...")
    static let opening_5_photoAlbum_alt2 = Dialog(Constants.mainCharacterName, prompt: "Just bad memories...")
    static let opening_6_radio_alt1 = Dialog(Constants.mainCharacterName, prompt: "I like this song. I play it all day.")
    static let opening_7_radio_alt2 = Dialog(Constants.mainCharacterName, prompt: "Not a fan of music.")
    static let opening_8_vase = Dialog(Constants.mainCharacterName, prompt: "It’s a vase.")
    static let opening_9_scribbleDoor = Dialog(Constants.mainCharacterName, prompt: "It’s a scribble of a door.")
    static let opening_10_manifestedDoor = Dialog(Constants.mainCharacterName, prompt: "Huh, the scribble became a door. Should I enter?") // Choice to 1. Enter; 2. Later
    
    // MARK: Office Scene
    static let office_1_photoframe_seq1 = Dialog(Constants.mainCharacterName, prompt: "This is my family photo. I think we took it last summer during mom’s birthday.")
    static let office_2_photoframe_seq2 = Dialog(Constants.mainCharacterName, prompt: "It was a great night...") // There's date on frame to indicate as a pin
    
    static let office_3_computer = Dialog(Constants.mainCharacterName, prompt: "My office computer. What was the pin again?") // Then, she type the pin.
    
    static let office_4_email_seq1 = Dialog(Constants.mainCharacterName, prompt: "Oh, there’s an email. ")
    static let office_5_email_seq2 = Dialog(Constants.mainCharacterName, prompt: "Ugh, this guy keeps giving me extra jobs and not paying me enough!!")
    static let office_6_email_seq3 = Dialog(Constants.mainCharacterName, prompt: "Thinking about him makes me shiver.")
    
    static let office_7_onphone_seq1 = Dialog(Constants.mainCharacterName, prompt: "Hello Mom")
    static let office_8_onphone_seq2 = Dialog(Constants.momName, prompt: "Mory! How are you doing? Have you eaten yet?")
    static let office_9_onphone_seq3 = Dialog(Constants.mainCharacterName, prompt: "I’m well mom. I haven’t eaten yet. I’m still working at the office right now.")
    static let office_10_onphone_seq4 = Dialog(Constants.momName, prompt: "What? It’s already 8 PM. Don’t get overworked.")
    static let office_11_onphone_seq5 = Dialog(Constants.mainCharacterName, prompt: "Wish I could do that if it weren’t for my manager.")
    static let office_12_onphone_seq6 = Dialog(Constants.momName, prompt: "Again?")
    static let office_13_onphone_seq7 = Dialog(Constants.mainCharacterName, prompt: "I’m tired, Mom. I Miss YOUU...")
    static let office_14_onphone_seq8 = Dialog(Constants.momName, prompt: "Aww… My poor daughter. It’s okay. Don’t worry too much.")
    static let office_15_onphone_seq9 = Dialog(Constants.momName, prompt: "Stress is a natural part of any job, but it's important to prioritize your well-being.")
    static let office_16_onphone_seq10 = Dialog(Constants.momName, prompt: "Never forget that you are not alone. Me and your dad are here to support you.")
    static let office_17_onphone_seq11 = Dialog(Constants.mainCharacterName, prompt: "...sob")
    static let office_18_onphone_seq12 = Dialog(Constants.momName, prompt: "Mory… Take a deep breath. I know you can handle it.")
    static let office_19_onphone_seq13 = Dialog(Constants.momName, prompt: "You've come so far, and this is just another hurdle on your path to success.")
    static let office_20_onphone_seq14 = Dialog(Constants.momName, prompt: "Just call me whenever you feel overwhelmed, okay? I’ll be here for you la.")
    static let office_21_onphone_seq15 = Dialog(Constants.mainCharacterName, prompt: "…Okay, mom…")
    static let office_22_onphone_seq16 = Dialog(Constants.momName, prompt: "I’m sending you foods after this, okay? Bye now, I have to make tea for your dad.")
    static let office_23_onphone_seq17 = Dialog(Constants.mainCharacterName, prompt: "Okay, bye, mom.")
    static let office_24_onphone_seq18 = Dialog(Constants.momName, prompt: "Don’t forget to eat, okay? Byebye.")
    static let office_25_onphone_seq19 = Dialog(nil, prompt: "“beep”")
    static let office_26_onphone_seq20 = Dialog(Constants.mainCharacterName, prompt: "...")
    static let office_27_onphone_seq21 = Dialog(Constants.mainCharacterName, prompt: "I feel motivated.")
    static let office_29_onphone_seq22 = Dialog(Constants.mainCharacterName, prompt: "Let’s get this work done.")
    
    static let office_30_rejectPhone = Dialog(Constants.mainCharacterName, prompt: "I need to get this work done asap.")
    
    // MARK: Bedroom Scene
    static let bedroom_1_solo_seq1 = Dialog(Constants.mainCharacterName, prompt: "So messy, what happened to my bedroom..?")
    static let bedroom_2_withPhoto_seq1 = Dialog(Constants.mainCharacterName, prompt: " Hmmm I need to put these photos to its places.")
    static let bedroom_3_withPhoto_seq2 = Dialog(Constants.mainCharacterName, prompt: "Done! It looks tidy. Bet I got some cleaning skills now.")
    static let bedroom_4_withPhoto_seq3 = Dialog(Constants.mainCharacterName, prompt: "Hmm, I’m having mixed feelings. What should I do with this album?")
    // Alternative 1: Keep album.
    static let bedroom_4_withPhoto_alt1_seq1 = Dialog(Constants.mainCharacterName, prompt: "Even though there are bad memories, there are still some of the good ones")
    // Alternative 2: Burn album.
    static let bedroom_4_withPhoto_alt2_seq2 = Dialog(Constants.mainCharacterName, prompt: "I have no need of these bad memories. Better burn them away.")
    
    // MARK: Bar Scene
    static let bar_1_solo_seq1 = Dialog(Constants.mainCharacterName, prompt: "Oh.. this is the bar that I frequently visited")
    static let bar_2_solo_seq1 = Dialog(Constants.mainCharacterName, prompt: "I need some music.")
    static let bar_3_solo_seq1 = Dialog(Constants.mainCharacterName, prompt: "I remember this song")
    // Alternative 1: Saved his life.
    static let bar_4_bartender_alt1_seq1 = Dialog(Constants.bartenderName, prompt: "Here’s your regular drink. Every time I see you, I always remember that day when you saved my life.")
    static let bar_5_bartender_alt1_seq2 = Dialog(Constants.mainCharacterName, prompt: "… I’m glad that I was able to pull you on time")
    static let bar_6_bartender_alt1_seq3 = Dialog(Constants.bartenderName, prompt: "Haha, we should see each other more.")
    static let bar_7_bartender_alt1_seq4 = Dialog(Constants.mainCharacterName, prompt: "Yeah, we should")
    static let bar_8_bartender_alt1_seq5 = Dialog(Constants.bartenderName, prompt: "Can I have your number?")
    static let bar_9_bartender_alt1_seq6 = Dialog(Constants.mainCharacterName, prompt: "Sure!")
    static let bar_10_bartender_alt1_seq7 = Dialog(Constants.mainCharacterName, prompt: "I need some music.")
    // Alternative 2: Not saved his life.
    static let bar_11_bartender_alt2_seq1 = Dialog(Constants.mainCharacterName, prompt: "1 drink please")
    static let bar_12_bartender_alt2_seq1 = Dialog(Constants.bartenderName, prompt: "1 drink coming up!")
}
