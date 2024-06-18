//import SwiftUI
//import AVFoundation
//
//class SoundManager {
//    static let shared = SoundManager()
//    private var audioPlayer: AVAudioPlayer?
//    
//    private init() {}
//    
//    func playSound() {
//        guard let path = Bundle.main.path(forResource: "soundJump", ofType: "mp3") else {
//            return
//        }
//        
//        let url = URL(fileURLWithPath: path)
//        
//        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: url)
//            audioPlayer?.play()
//        } catch {
//            print("Error: Could not initialize AVAudioPlayer - \(error.localizedDescription)")
//        }
//    }
//}
