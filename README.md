# ieducateStaffAttendance
this is an internship project that is going to provide an alternative option for staff punch in and punch out with signature handling as well

# things involved
asynchonously function, GCD(grand central dispatch), completion handler, MVC-N, Uitableviewcontroller, custom uitableview cell, containerviewcontroller, alamofire, EPSignature(a great open source github project that takes signature)

# description of the project

this project is implemented in a MVC-N design pattern with swift. i have a network folder that contains class staffdatafromserver which using alamofire to request staff data from the server, the data includes staff name, staff image, staff last onsite information. i broke down network requests into 3 seperate functions, that retrieve different kinds of data(1.basic staff information, 2.image, 3. staff last on site status)After retrieving the basic staff information, it will start to fill the staff object(a custom object that hold data of a specific staff ) in a staff objects array, and then the 2nd function will use the unique id(table name) to retrieve image separately as well as asynchonously by using GCD(grand central dispatch), each time this function retrieved an image, it will be inserted correctly to the specific staff in the staff objects array, after retrieved all the images, it will start to call the 3rd function to get staff's last on site status from the server, and fill into the staff objects in staff array, these 2 network request functions are called one after each other by using completion handler.


when all the needed information is completed, the staff array will be broke down into 2 separate dictionaries to hold different groups of staff depends on whether they are online or offline, then the program will start to fill online and offline sections of Uitableview by using the separated dictionariesy, i used custom cell class to display users' image
and name which will be meaningful and identical when staff wants to sign in(they can choose themselves in uitableview to punch in/punch out), while the cell also has a properties "uid" which is used to store tablename of the staff in server, and to be used to be delivered into detailview when user finished drawing their signature, 
and submit to server and inserted into correct staff table by using uid


after staff clicked the tableview cell, they will be directed to their detail view, and a signature pad will pop up automatically for them to sign in, in this case, i used a github open source project EPSignature to accpet users signature, this epsigntureview is nested in a container view in stafftable cell detail view and is fully functioning(you can cancel, you can click done to submit the signature and the signature will be assigned to a uiview for user to view), if the staff clicked cancel, they will be directed back to staff detailview, a configure signature button allows them to re-do their signature, if they don't like the one that they've already done :)

currently, i am constructing the post staff information back to server function



<img src="https://github.com/JoeyZhou1006/ieducateStaffAttendance/blob/master/screenshotsblurry.png" alt="alt text" width="300" height="500">

<img src="https://github.com/JoeyZhou1006/ieducateStaffAttendance/blob/master/Screen%20Shot%202016-12-09%20at%2012.19.48%20am.png" alt="alt text" width="300" height="500">
<img src="https://github.com/JoeyZhou1006/ieducateStaffAttendance/blob/master/IMG_4820.PNG" alt="alt text" width="300" height="500">

<img src="https://github.com/JoeyZhou1006/ieducateStaffAttendance/blob/master/Screen%20Shot%202016-12-09%20at%2012.20.25%20am.PNG" alt="alt text" width="300" height="500">
<img src="https://github.com/JoeyZhou1006/ieducateStaffAttendance/blob/master/IMG_4818.PNG" alt="alt text" width="300" height="500">
<img src="https://github.com/JoeyZhou1006/ieducateStaffAttendance/blob/master/IMG_4819.PNG" alt="alt text" width="300" height="500">
<img src="https://github.com/JoeyZhou1006/ieducateStaffAttendance/blob/master/IMG_4817.PNG" alt="alt text" width="300" height="500">









