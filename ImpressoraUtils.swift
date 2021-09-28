//
//  ImpressoraUtils.swift
//
//
//  Created by Gabriel Messias on 27/09/21.
//

import UIKit
import PDFKit

class ImpressoraUtils {
    
    static func imprimir(printName: String, imagem: UIImage) {
        let info = UIPrintInfo(dictionary:nil)
        info.outputType = UIPrintInfo.OutputType.general
        info.jobName = printName

        let vc = UIPrintInteractionController.shared
        vc.printInfo = info

        let image: UIImage = imagem
        UIGraphicsEndImageContext()

        vc.printingItem = image

        vc.present(animated: true, completionHandler: nil)
    }
    
    static func imprimir(printName: String, view: UIView) {
        let info = UIPrintInfo(dictionary:nil)
        info.outputType = UIPrintInfo.OutputType.general
        info.jobName = printName

        let vc = UIPrintInteractionController.shared
        vc.printInfo = info
        
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)

        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        vc.printingItem = image

        vc.present(from: view.frame, in: view, animated: true, completionHandler: nil)
    }
    
    static func imprimir(printName: String, data: Data) {
        let info = UIPrintInfo(dictionary:nil)
        info.outputType = UIPrintInfo.OutputType.general
        info.jobName = printName

        let vc = UIPrintInteractionController.shared
        vc.printInfo = info
        
        vc.printingItem = data

        vc.present(animated: true, completionHandler: nil)
    }
}
