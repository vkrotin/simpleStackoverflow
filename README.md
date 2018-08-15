[![License](https://img.shields.io/cocoapods/l/ASNotificationCenter.svg?style=flat)](http://cocoapods.org/pods/ASNotificationCenter)
[![Platform](https://img.shields.io/cocoapods/p/ASNotificationCenter.svg?style=flat)](http://cocoapods.org/pods/ASNotificationCenter)

# simpleStackoverflow
Search issues by name on stackoverflow.

The screen shows input field for a search query. The user enters a search query. 
Through the API you will get a list of questions, the title of which includes the user-entered query.

The resulting list of questions is displayed in a UITableView. The cell should contain the following information:
* The full title of the question. The height of the cell changes depending on the length of the header (if the header does not fit in one line).
* User avatar
* Username
* The creation date of the question.
* The number of responses to this question.

By clicking on the item in the table open the page with the corresponding question in safari.
By clicking on the avatar opened in Mozilla user profile, asked a question.

![](screens/s1.png)
