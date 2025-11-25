import SwiftUI
import UIKit

extension UIImage {
    /// Extracts the average/dominant color from the image using Core Image
    func averageColor() -> UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        
        let extentVector = CIVector(
            x: inputImage.extent.origin.x,
            y: inputImage.extent.origin.y,
            z: inputImage.extent.size.width,
            w: inputImage.extent.size.height
        )
        
        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [
            kCIInputImageKey: inputImage,
            kCIInputExtentKey: extentVector
        ]) else { return nil }
        
        guard let outputImage = filter.outputImage else { return nil }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull as Any])
        context.render(
            outputImage,
            toBitmap: &bitmap,
            rowBytes: 4,
            bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
            format: .RGBA8,
            colorSpace: nil
        )
        
        return UIColor(
            red: CGFloat(bitmap[0]) / 255,
            green: CGFloat(bitmap[1]) / 255,
            blue: CGFloat(bitmap[2]) / 255,
            alpha: CGFloat(bitmap[3]) / 255
        )
    }
    
    /// Generates a gradient-friendly color palette from the image
    func extractColorPalette() -> [Color] {
        guard let avgColor = averageColor() else {
            return [.blue, .purple, .indigo] // Fallback
        }
        
        let swiftUIColor = Color(avgColor)
        
        // Create a harmonious gradient from the dominant color
        return [
            swiftUIColor.opacity(0.8),
            swiftUIColor.opacity(0.6),
            swiftUIColor.adjustBrightness(by: -0.1).opacity(0.5),
            swiftUIColor.adjustBrightness(by: -0.2).opacity(0.4)
        ]
    }
}

extension Color {
    /// Adjusts the brightness of a color
    func adjustBrightness(by amount: Double) -> Color {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        UIColor(self).getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        return Color(
            hue: Double(hue),
            saturation: Double(saturation),
            brightness: max(0, min(1, Double(brightness) + amount))
        )
    }
}
