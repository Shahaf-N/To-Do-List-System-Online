# To-Do-List-System-Online

To do list system web application, using java servlets, JSP, CSS and HTML.
Login and register pages that fill into database so everyone can use it.
When you log in a cookie will with your name so if you come back it will remember you so you don't need to login again.
For each task you can fill name, description, priority from 1-3 and a deadline.
Saves users data devided to List's of task's and task's.
A list of task's can be always managed(adding and removing task).
Each task has a priority number from 1-3 so when someone is viewing the list it will be sorted by priority's.
Every user can view his tasks at any moment and update them.
You can check the task when you have completed it.
There is a logout button that will logout you out of the system.



To start using the project you will need to setup DB with 3 tables with values (LISTS(NAME(VARCHAR:200),USEREMAIL(VARCHAR:200))
,TASKS(NAME(VARCHAR:200),DESCRIPTION(VARCHAR:200),PRIORITY(SMALLINT),DEADLINE(DATE),FLAG(BOOLEAN),USEREMAIL(VARCHAR:200)),
USERS(FNAME(VARCHAR:200),LNAME(VARCHAR:200),EMAIL(VARCHAR:200),PASSWORD(VARCHAR:200),BDAY(DATE),AGE(SMALLINT),GENDER(BOOLEAN))).

The data base that i used is also linked in the start with the project.
