import UserNotifications
import FirebaseMessaging

class NotificationService: UNNotificationServiceExtension {

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        guard let bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent) else {
            contentHandler(request.content)
            return
        }

        // Check if the image URL exists in the notification payload
        if let imageURLString = bestAttemptContent.userInfo["image"] as? String,
           let imageURL = URL(string: imageURLString) {
            
            // Log the URL for debugging
            print("Downloading image from URL: \(imageURL)")

            // Download the image
            downloadImage(from: imageURL) { attachment in
                if let attachment = attachment {
                    bestAttemptContent.attachments = [attachment]
                }
                contentHandler(bestAttemptContent)
            }
        } else {
            contentHandler(bestAttemptContent)
        }
    }

    // Function to download the image
    private func downloadImage(from url: URL, completion: @escaping (UNNotificationAttachment?) -> Void) {
        let task = URLSession.shared.downloadTask(with: url) { (location, _, error) in
            guard let location = location, error == nil else {
                print("Error downloading image: \(error?.localizedDescription ?? "unknown error")")
                completion(nil)
                return
            }

            let fileManager = FileManager.default
            let tempDirectory = NSTemporaryDirectory()
            let uniqueName = ProcessInfo.processInfo.globallyUniqueString

            // Determine the file extension based on the downloaded image
            let fileExtension = url.pathExtension.lowercased()
            let tempFile = tempDirectory.appending("/\(uniqueName).\(fileExtension)") // Save with dynamic extension
            let tempURL = URL(fileURLWithPath: tempFile)

            do {
                try fileManager.moveItem(at: location, to: tempURL)
                let attachment = try UNNotificationAttachment(identifier: uniqueName, url: tempURL, options: nil)
                completion(attachment)
            } catch {
                print("Error creating attachment: \(error.localizedDescription)")
                completion(nil)
            }
        }
        task.resume()
    }
}
