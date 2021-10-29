//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by 高橋　義一 on 2021/10/26.
//

import UIKit
import FirebaseStorageUI

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPostData(_ postData: PostData) {
        postImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.commentLabel.numberOfLines = 0
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postData.id + ".jpg")
        postImageView.sd_setImage(with: imageRef)

        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"

        self.dateLabel.text = ""
        if let date = postData.date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateString = formatter.string(from: date)
            self.dateLabel.text = dateString
        }

        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"

        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
        if postData.comments.count > 0 {
            var commentsString = ""
            
            let dataArray = postData.comments.keys.sorted { $0 < $1 }
            print(dataArray)
            for c in dataArray {
                commentsString += "\(c.components(separatedBy: "_")[1]) : \((postData.comments[c])!) \n"
            }
            print(commentsString)
            self.commentLabel.text = commentsString
        }else {
            self.commentLabel.text = ""
        }
    }
    
}
