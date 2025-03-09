import UIKit
import NaturalLanguage

class ChatBotViewController: UIViewController {
    
    @IBOutlet weak var userInputField: UITextField!
    @IBOutlet weak var chatTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTextView.text = "Twizzler: Hello! Ask me anything."
        checkFileBundle()

    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        guard let userInput = userInputField.text, !userInput.isEmpty else { return }
        
        // Preprocess and classify the intent of the input
        let response = classifyUserInput(userInput)
        
        // Format chat message with bold sender name and spacing
        let formattedUserMessage = formatChatMessage(sender: "You", message: userInput)
        let formattedBotMessage = formatChatMessage(sender: "Twizzler", message: response)
        
        // Append formatted messages
        let newChatText = NSMutableAttributedString(attributedString: chatTextView.attributedText)
        if newChatText.length > 0 {
            newChatText.append(NSAttributedString(string: "\n\n")) // Space between messages
        }
        newChatText.append(formattedUserMessage)
        newChatText.append(NSAttributedString(string: "\n\n")) // Extra space
        newChatText.append(formattedBotMessage)
        
        chatTextView.attributedText = newChatText
        
        // Clear the input field
        userInputField.text = ""
        
        // Scroll to the bottom of the chat text view
        chatTextView.scrollRangeToVisible(NSRange(location: chatTextView.text.count - 1, length: 1))
    }

    // Function to format chat messages with bold sender names
    func formatChatMessage(sender: String, message: String) -> NSAttributedString {
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16)
        ]
        
        let attributedString = NSMutableAttributedString(string: sender + ": ", attributes: boldAttributes)
        attributedString.append(NSAttributedString(string: message, attributes: normalAttributes))
        
        return attributedString
    }

    
    // Function to classify user input using NLP
    func classifyUserInput(_ input: String) -> String {
        let tagger = NLTagger(tagSchemes: [.lexicalClass])
        tagger.string = input
        
        var response: String? = nil
        
        // Iterate over all words in the input string
        tagger.enumerateTags(in: input.startIndex..<input.endIndex, unit: .word, scheme: .lexicalClass) { (tag, range) in
            let word = String(input[range])
            print("Processing word: \(word), Tag: \(tag)") // Debugging line
            
            if tag == .noun {
                // Check if the word contains keywords related to budgeting, loans, or taxes
                if word.lowercased().contains("budget") {
                    print("Found 'budget' keyword!") // Debugging line
                    response = searchFile(named: "budgeting", forKeyword: word)
                } else if word.lowercased().contains("loan") {
                    print("Found 'loan' keyword!") // Debugging line
                    response = searchFile(named: "loans", forKeyword: word)
                } else if word.lowercased().contains("tax") {
                    print("Found 'tax' keyword!") // Debugging line
                    response = searchFile(named: "taxes", forKeyword: word)
                }
            }
            return true // Continue enumerating through the words
        }
        
        // If no relevant keyword is found, provide a default response
        if let response = response {
            return response
        } else {
            return "I'm not sure what you're asking about. Could you clarify?"
        }
    }
    
    // Function to read the text file and search for a keyword
    func searchFile(named fileName: String, forKeyword keyword: String) -> String {
        if let filePath = Bundle.main.path(forResource: fileName, ofType: "txt") {
            do {
                let fileContent = try String(contentsOfFile: filePath, encoding: .utf8)
                let lines = fileContent.components(separatedBy: "\n")

                var foundQuestion = false
                var answer = ""

                for line in lines {
                    let trimmedLine = line.trimmingCharacters(in: .whitespacesAndNewlines)

                    if trimmedLine.lowercased().contains(keyword.lowercased()) && trimmedLine.starts(with: "Q:") {
                        foundQuestion = true  // Mark that we found the question
                    } else if foundQuestion && trimmedLine.starts(with: "A:") {
                        answer = trimmedLine.replacingOccurrences(of: "A: ", with: "")  // Extract answer
                        break
                    }
                }

                if !answer.isEmpty {
                    return "Here's the answer: \(answer)"
                } else {
                    return "I found a related question, but no answer was available."
                }

            } catch {
                return "Error reading file."
            }
        } else {
            return "File not found."
        }
    }

    
    // Function to extract relevant sections from the file content based on keyword
    func extractRelevantSection(from content: String, withKeyword keyword: String) -> String {
        // Split the content into sections based on "Q:" (question marker)
        let sections = content.split(separator: "\n").map { String($0) }
        
        var relevantSection: String? = nil
        
        for section in sections {
            // Check if the section contains the keyword (case-insensitive)
            if section.lowercased().contains(keyword.lowercased()) {
                relevantSection = section
                break
            }
        }
        
        // If a relevant section is found, return it, otherwise indicate no match
        if let relevantSection = relevantSection {
            return "Here's some relevant information: \(relevantSection)"
        } else {
            return "Sorry, I couldn't find a relevant answer to your question."
        }
    }
    func checkFileBundle() {
        // List of the filenames you expect to have in your bundle
        let fileNames = ["budgeting.txt", "loans.txt", "taxes.txt"]
        
        for fileName in fileNames {
            if let filePath = Bundle.main.path(forResource: fileName, ofType: "txt") {
                print("File \(fileName) is found at path: \(filePath)")
            } else {
                print("File \(fileName) not found in the bundle.")
            }
        }
    }

}
