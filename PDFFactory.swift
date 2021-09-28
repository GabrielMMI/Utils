//
//  PDFFactory.swift
//
//
//  Created by Gabriel Messias on 28/09/21.
//

import UIKit
import PDFKit

// How to use
/*
 let pdfData = PDFFactory.createPDF(componentes: { pageRect in
     
     let headerHeight = PDFFactory.addImage(pageRect: pageRect, image: UIImage(named: "header") ?? UIImage(), imageSize: CGSize(width: pageRect.width * 1.2, height: 77.0), y: 0.0)

     let nameHeight = PDFFactory.addText(pageRect: pageRect, text: "Gabriel Messias", y: headerHeight + 40.0, fonte: UIFont.boldSystemFont(ofSize: 30.0))

     let titleHeight = PDFFactory.addText(pageRect: pageRect, text: "Titulo", y: nameHeight + 20.0, fonte: UIFont.boldSystemFont(ofSize: 30.0))

     let subtitleHeight = PDFFactory.addText(pageRect: pageRect, text: "Subtitulo", y: titleHeight + 8.0, fonte: UIFont.systemFont(ofSize: 24.0))

     let imageHeight = PDFFactory.addImage(pageRect: pageRect, image: UIImage(named: "qrcodeTeste") ?? UIImage(), imageSize: CGSize(width: 400.0, height: 400.0), y: subtitleHeight + 25.0)

     _ = PDFFactory.addText(pageRect: pageRect, text: "CAIXA | O banco de todos os brasileiros", y: imageHeight + 25.0, fonte: UIFont.boldSystemFont(ofSize: 30.0))
 })
*/

class PDFFactory {
    
    static func createPDF(componentes: (_ pageRect: CGRect) -> ()) -> Data {
        let pdfMetaData = [
            kCGPDFContextCreator: "Creator PDF",
            kCGPDFContextAuthor: "Author PDF"
        ]
        
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        let pageWidth = 8.5 * 72.0
        let pageHeight = 11 * 72.0
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: formato)
        
        let data = renderer.pdfData { context in
            context.beginPage()
            
            componentes(pageRect)
        }
        UIGraphicsEndImageContext()
        
        return data
    }
    
    static func addText(pageRect: CGRect, text: String, y: CGFloat, fonte: UIFont) -> CGFloat {
        
        let tituloAtributos: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: fonte,
             NSAttributedString.Key.foregroundColor: AppColors.primaryDarkBlueDinamico.color]

        let tituloAttributted = NSAttributedString(
            string: text,
            attributes: tituloAtributos
        )

        let tituloSize = tituloAttributted.size()

        let tituloRect = CGRect(
            x: (pageRect.width - tituloSize.width) / 2.0,
            y: y,
            width: tituloSize.width,
            height: tituloSize.height
        )

        tituloAttributted.draw(in: tituloRect)

        return tituloRect.origin.y + tituloRect.size.height
    }
    
    static func addImage(pageRect: CGRect, image: UIImage, imageSize: CGSize, y: CGFloat) -> CGFloat {
        
        let imageX = (pageRect.width - imageSize.width) / 2.0
        let imageRect = CGRect(
            x: imageX,
            y: y,
            width: imageSize.width,
            height: imageSize.height
        )

        image.draw(in: imageRect)
        return imageRect.origin.y + imageRect.size.height
    }
}
