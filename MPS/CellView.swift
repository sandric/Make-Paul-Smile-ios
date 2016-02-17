//
//  CellView.swift
//  MPS
//
//  Created by sandric on 17.02.16.
//  Copyright © 2016 sandric. All rights reserved.
//

import UIKit


class CellView : UIView {
    
    var cell:Cell!
    
    init(frame: CGRect, cell: Cell) {
        
        super.init(frame: frame)
        
        self.cell = cell
        
        self.tag = self.cell.getTag()
        
        self.draw()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func draw() {
        self.backgroundColor = self.getColor()
        if !self.cell.isEmpty() {
            self.drawPiece()
        }
    }
    
    func drawPiece() {
        
        let resizedPieceImage: UIImage = CellView.resizeImage(self.cell.piece.imagePath(), ToSize: self.bounds.size)
        
        let resizedPieceImageWithBackgound: UIImage = CellView.combineImage(resizedPieceImage, withBackgroundColor: self.getColor())
        
        self.backgroundColor = UIColor(patternImage: resizedPieceImageWithBackgound)
    }
    
    func getColor() -> UIColor {
        
        var color: UIColor!
        
        if self.cell.isSelected {
            color = UIColor.greenColor()
        } else if self.cell.isExpected {
            color = UIColor.yellowColor()
        } else if self.cell.isValid {
            color = UIColor.blueColor()
        } else if self.cell.color == "white" {
            color = UIColor.whiteColor()
        } else if self.cell.color == "black" {
            color = UIColor.lightGrayColor()
        }
        
        return color
    }
    
    class func combineImage(image: UIImage, withBackgroundColor bgColor: UIColor) -> UIImage {
        
        let rect: CGRect = CGRectMake(0, 0, image.size.width, image.size.height)
        UIGraphicsBeginImageContext(rect.size)
        
        let context: CGContextRef = UIGraphicsGetCurrentContext()!
        
        CGContextSaveGState(context)
        
        bgColor.setFill()
        
        CGContextFillRect(context, rect)
        
        image.drawInRect(rect)
        
        let imageWithBackground: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return imageWithBackground
    }
    
    class func resizeImage(imageName: String, ToSize size: CGSize) -> UIImage {
        
        let image: UIImage = UIImage(named: imageName)!
        
        UIGraphicsBeginImageContext(size)
        
        image.drawInRect(CGRectMake(0, 0, size.width, size.height))
        
        let resizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return resizedImage
    }

}

