//
//  DialogResources.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 24/06/23.
//

import SpriteKit

struct DialogResources {
    
    // MARK: Fallbacks
    static let toBarBlockedFallback = Dialog(Constants.mainCharacterName, prompt: "The door is tightly closed")
    
    // MARK: Opening Scene
    static let opening1SoloSequence = [
        Dialog(Constants.mainCharacterName, prompt: "Where am I? I feel a bit dizzy."),
        Dialog(Constants.mainCharacterName, prompt: "Where is this? It looks so strange...")
    ]
    
    // MARK: Main Scene
    static let main1OfficeDeskAlt1 = Dialog(Constants.mainCharacterName, prompt: "Oh! My family photo. It was a great night.")
    
    static let main2OfficeDeskAlt2 = Dialog(Constants.mainCharacterName, prompt: "Sigh… There are still a lot of work to do.")
    
    static let main3PhotoAlbumAlt1 = Dialog(Constants.mainCharacterName, prompt: "A collection of photos with my friends...")
    
    static let main4PhotoAlbumAlt2 = Dialog(Constants.mainCharacterName, prompt: "Just bad memories...")
    
    static let main5RadioAlt1 = Dialog(Constants.mainCharacterName, prompt: "I like this song. I play it all day.")
    
    static let main6RadioAlt2 = Dialog(Constants.mainCharacterName, prompt: "Not a fan of music.")
    
    static let main7Vase = Dialog(Constants.mainCharacterName, prompt: "It’s a vase.")
    
    static let main8ScribbleDoor = Dialog(Constants.mainCharacterName, prompt: "It’s a scribble of a door.")
    
    static let main9ManifestedDoor = Dialog(Constants.mainCharacterName, prompt: "Huh, the scribble became a door. Should I enter?") // Choice to 1. Enter; 2. Later
    
    // MARK: Office Scene
    static let office1Solo = Dialog(Constants.mainCharacterName, prompt: "Office, really? Is it a good idea to come here?")
    
    static let office2PhotoFrameSequence = [
        Dialog(Constants.mainCharacterName, prompt: "This is my family photo. I think we took it last summer during mom’s birthday."),
        Dialog(Constants.mainCharacterName, prompt: "It was a great night...")
    ]
    
    static let office3Computer = Dialog(Constants.mainCharacterName, prompt: "My office computer. What was the pin again?")
    
    static let office4EmailSequence = [
        Dialog(Constants.mainCharacterName, prompt: "Oh, there’s an email. "),
        Dialog(Constants.mainCharacterName, prompt: "Ugh, this guy keeps giving me extra jobs and not paying me enough!!"),
        Dialog(Constants.mainCharacterName, prompt: "Thinking about him makes me shiver.")
    ]
    
    static let office5OnPhoneSequence = [
        Dialog(Constants.mainCharacterName, prompt: "Hello Mom"),
        Dialog(Constants.momName, prompt: "Mory! How are you doing? Have you eaten yet?"),
        Dialog(Constants.mainCharacterName, prompt: "I’m well mom. I haven’t eaten yet. I’m, still working at the office right now."),
        Dialog(Constants.momName, prompt: "What? It’s already 8 PM. Don’t get overworked."),
        Dialog(Constants.mainCharacterName, prompt: "Wish I could do that if it weren’t for my, manager."),
        Dialog(Constants.momName, prompt: "Again?"),
        Dialog(Constants.mainCharacterName, prompt: "I’m tired, Mom. I Miss YOUU..."),
        Dialog(Constants.momName, prompt: "Aww… My poor daughter. It’s okay. Don’t worry too, much."),
        Dialog(Constants.momName, prompt: "Stress is a natural part of any job, but it's, important to prioritize your well-being."),
        Dialog(Constants.momName, prompt: "Never forget that you are not alone. Me and your dad, are here to support you."),
        Dialog(Constants.mainCharacterName, prompt: "...sob"),
        Dialog(Constants.momName, prompt: "Mory… Take a deep breath. I know you can handle it."),
        Dialog(Constants.momName, prompt: "You've come so far, and this is just another hurdle, on your path to success."),
        Dialog(Constants.momName, prompt: "Just call me whenever you feel overwhelmed, okay?, I’ll be here for you la."),
        Dialog(Constants.mainCharacterName, prompt: "…Okay, mom…"),
        Dialog(Constants.momName, prompt: "I’m sending you foods after this, okay? Bye now, I, have to make tea for your dad."),
        Dialog(Constants.mainCharacterName, prompt: "Okay, bye, mom."),
        Dialog(Constants.momName, prompt: "Don’t forget to eat, okay? Byebye."),
        Dialog(nil, prompt: "“beep”"),
        Dialog(Constants.mainCharacterName, prompt: "..."),
        Dialog(Constants.mainCharacterName, prompt: "I feel motivated."),
        Dialog(Constants.mainCharacterName, prompt: "Let’s get this work done.")
    ]
    
    static let office6RejectPhone = Dialog(Constants.mainCharacterName, prompt: "I need to get this work done asap.")
    
    // MARK: Bedroom Scene
    static let bedroom1Solo = Dialog(Constants.mainCharacterName, prompt: "So messy, what happened to my bedroom..?")
    
    static let bedroom2WithPhoto = Dialog(Constants.mainCharacterName, prompt: " Hmmm I need to put these photos to their places.")
    
    static let bedroom3WithPhoto = Dialog(Constants.mainCharacterName, prompt: "Hmm, I’m having mixed feelings. What should I do with this album?")
    
    // Alternative 1: Keep album.
    static let bedroom4WithPhotoAlt1 = Dialog(Constants.mainCharacterName, prompt: "Even though there are bad memories, there are still some of the good ones")
    
    // Alternative 2: Burn album.
    static let bedroom4WithPhotoAlt2 = Dialog(Constants.mainCharacterName, prompt: "I have no need of these bad memories. Better burn them away.")
    
    static let bedroom5AfterCleaning = Dialog(Constants.mainCharacterName, prompt: "Done! It looks tidy. Bet I got some cleaning skills now.")
    
    // MARK: Bar Scene
    static let bar1Solo = Dialog(Constants.mainCharacterName, prompt: "Oh.. this is the bar that I frequently visited")
    
    static let bar2Solo = Dialog(Constants.mainCharacterName, prompt: "I need some music.")
    
    static let bar3Solo = Dialog(Constants.mainCharacterName, prompt: "I remember this song")
    
    // Alternative 1: Saved his life.
    static let bar4BartenderAlt1Sequence = [
        Dialog(Constants.bartenderName, prompt: "Here’s your regular drink."),
        Dialog(Constants.bartenderName, prompt: "Every time I see you, I always remember that day when you saved my life."),
        Dialog(Constants.mainCharacterName, prompt: "… I’m glad that I was able to pull you on time"),
        Dialog(Constants.bartenderName, prompt: "Haha, we should see each other more."),
        Dialog(Constants.mainCharacterName, prompt: "Yeah, we should"),
        Dialog(Constants.bartenderName, prompt: "Can I have your number?"),
        Dialog(Constants.mainCharacterName, prompt: "Sure!"),
        Dialog(Constants.bartenderName, prompt: "Thank you!")
    ]
    
    // Alternative 2: Not saved his life.
    static let bar4BartenderAlt2Sequence = [
        Dialog(Constants.mainCharacterName, prompt: "1 drink please"),
        Dialog(Constants.bartenderName, prompt: "1 drink coming up!")
    ]
    
    // MARK: Hospital scene
    static let hospital1Solo = Dialog(Constants.mainCharacterName, prompt: "Ugh… I just had the weirdest dream…")
    
    static let hospital2ParentSequence = [
        Dialog(Constants.momName, prompt: "Mory!"),
        Dialog(Constants.mainCharacterName, prompt: "Where are we..?"),
        Dialog(Constants.momName, prompt: "We’re in the hospital! It’s been a week since you were found unconscious in your room. "),
        Dialog(Constants.dadName, prompt: "We were so worried!"),
        Dialog(Constants.momName, prompt: "We were afraid we lost you."),
        Dialog(Constants.mainCharacterName, prompt: "I’m sorry.."),
        Dialog(Constants.momName, prompt: "Don't you dare apologize. We would go through anything for you. We've been by your side every step of the way, praying and hoping for this moment."),
        Dialog(Constants.mainCharacterName, prompt: "Thanks, mom.. dad... Thank you for never giving up on me")
    ]
    
    static let hospital3FriendSequence = [
        Dialog(Constants.friend1Name, prompt: "Mory! We’re so worried"),
        Dialog(Constants.mainCharacterName, prompt: "What are you guys doing here..?"),
        Dialog(Constants.friend2Name, prompt: "When we found out you were unconscious in your room, of course we come running."),
        Dialog(Constants.friend1Name, prompt: "I’m sorry that we weren’t there for you!"),
        Dialog(Constants.mainCharacterName, prompt: "It’s okay, i appreciate you guys for being here."),
        Dialog(Constants.friend2Name, prompt: "We are glad that you here with us now.")
    ]
    
    static let hospital4BartenderSequence = [
        Dialog(Constants.bartenderName, prompt: "Mory! How are you feeling?"),
        Dialog(Constants.mainCharacterName, prompt: "I.. I think I’m fine, Why are you here?"),
        Dialog(Constants.bartenderName, prompt: "The hospital called me, they say you were found unconscious in your room."),
        Dialog(Constants.mainCharacterName, prompt: "Shouldn’t you be working?"),
        Dialog(Constants.bartenderName, prompt: "You are more far more important than my job."),
        Dialog(Constants.mainCharacterName, prompt: "Oh…Thank you so much for being here with me."),
        Dialog(Constants.bartenderName, prompt: "I’m glad you woke up, I’ll always be here for you.")
    ]
    
    static let hospital2SoloAlt2Sequence = [
        Dialog(Constants.mainCharacterName, prompt: "Ugh… I just had the weirdest dream..."),
        Dialog(Constants.mainCharacterName, prompt: "Am I…. in the hospital? "),
        Dialog(Constants.mainCharacterName, prompt: "What have i done?! I should’ve been more thoughtful... now I have no one by my side...")
    ]
}
