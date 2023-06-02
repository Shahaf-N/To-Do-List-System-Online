

package SRTDLSystem;

import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;



public class User implements Serializable{
    //member variables
    private String fname,lname,email,password,bdate,age,gender;
    private ArrayList<TaskList> taskl;
    
    //constructors
    public User(String fn,String ln,String em,String pass,String bd,String a,String g){
        fname = fn;
        lname = ln;
        email = em;
        password = pass;
        bdate = bd;
        age = a;
        gender = g;
        taskl = new ArrayList<TaskList>();
    }
    
    //equals override
    @Override
    public boolean equals(Object o){
       if(o instanceof User){
            User u = (User)o;
            return fname.equals(u.fname) && lname.equals(u.lname) && email.equals(u.email) && password.equals(u.password);
       }
       else
           return false;
    }
    //geters and seters
    public String getFname(){
        return fname;
    }
    public String getLname(){
        return lname;
    }
    public boolean getGender(){
        return gender.equals("male");
    }
    public int getAge(){
        return Integer.parseInt(age);
    }
    public String getBdate(){
        return bdate;
    }
    public String GetEmail(){
        return email;
    }
    public String GetPass(){
        return password;
    }
    public ArrayList<TaskList> getLists(){
        return taskl;
    }
    //find specify tasklist in user
    public TaskList FindSpecifyList(String lna){
        TaskList temp = new TaskList(lna);
        for (TaskList l : taskl)
            if (l.equals(temp))
                return l;
        return null;
    }
    public void AddList(TaskList l){
        taskl.add(l);
    }
    //true for added, false for already exist
    public boolean AddNewList(String name){
        if (FindSpecifyList(name)!=null)
            return false;
        taskl.add(new TaskList(name));
        return true;
    }
    public boolean AddNewTask(String lna,Task t){
        TaskList tli = FindSpecifyList(lna);
        if (tli==null){
            this.AddNewList(lna);
            AddNewTask(lna, t);
            return true;
        }
        if (tli.ContainTask(t)){
            System.out.println("This task already exists!");
            return false;
        }
        tli.AddTask(t);
        return true;
    }
    public String ShowSpecifiedList(String lna){
        TaskList l =FindSpecifyList(lna);
        if (l==null){
            return "";
        }
        return l.toString();
    }
    public boolean MarkTaskDone(String lna,String tna){
        TaskList tli = FindSpecifyList(lna);
        if (tli == null){
            return false;
        }
        return tli.TaskDone(tna);
    }
    
    public void DeleteList(String lna){
        taskl.remove(new TaskList(lna));
    }
    
    public void DeleteTask(String lname, Task t){
        for(int i=0 ; i<taskl.size() ; i++)
            if(taskl.get(i).equals(new TaskList(lname))){
                taskl.get(i).removeTask(t);
            }
    }
        // user cookie will be created by following pattern: FName LName:email:password
    public String CreateUserCookie(){
        String c="pink";
        if (gender.equals("male"))
            c="blue";
        return fname + ":" + c + ":" + email + ":" + password;
    }

    public String show(String name,String color,String logout){
        String header = "<!DOCTYPE html>\n" +
            "<html>\n" +
            "    <head>\n" +
            "        <title>To Do List System</title>\n" +
            "        <link rel=\"stylesheet\" type=\"text/css\" media=\"all\" href=\"css/style.css\">\n" +
            "        <meta charset=\"UTF-8\">\n" +
            "        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n" +
            "        <meta http-equiv=\"Expires\" content=-10>" +
            "    </head>\n" +
            "    <body>\n" +
            "        <script src=\"js/code.js\" defer></script>\n" +
            "        <header>\n" +
            "            <a href=\".\\MainPage.jsp\"><img src=\"logo.png\" height=\"50\" width=\"50\"></a>\n" +
            "            <h1>To Do List</h1>\n" +
            "            <h4 >Hello <span style=\"color: "+color+"\">" + name + "</span> "+logout+"</h4>\n" +
            "        </header>" +
            "        <div class=\"slist\" >\n" +
            "            <div class=\"slisth\">\n" +
            "                <h1>All list's of task's</h1></br>\n" +
            "                <h2>You can see all your list's and task's down below:</h2></br>\n" +
            "            </div>";
        
        String footer = "</div>\n" +
            "        <footer>\n" +
            "            <p>Shahaf Nachum, Raz Chai | <a href=\"https://www.netanya.ac.il/\" target=\"_blank\">Netanya Academy College</a></p>\n" +
            "        </footer>\n" +
            "    </body>\n" +
            "</html>\n";
        
        String content = "";
        
        for(TaskList l: taskl)
            content += displayList(l);
        
        if(content.equals(""))
            content = "<p style=\"color:yellow\">there are no existing task lists</p>";
        return header + content + footer;
    }
    
    private String displayList(TaskList l){
        String[] sList = l.toString().split("\n");
        String header = "<div class=\"slfields\">\n" +
                        "                <table id=\"listable\">\n" +
                        "                    <tr>\n" +
                        "                        <th>" + sList[0] + "</th>\n" +
                        "                    </tr>\n" +
                        "                    <tr>\n" +
                        "                        <th>Name</th>\n" +
                        "                        <th>Description</th>\n" +
                        "                        <th>Priority</th>\n" +
                        "                        <th>Date</th>\n" +
                        "                        <th>Done</th>\n" +
                        "                    </tr>";
        String content = "";
        
        String footer = "                </table>\n" +
                        "                <form action=\"#\" method=\"post\"><input type=\"hidden\" name=\"dList\" value=\""+ sList[0] +"\"><input type=\"submit\" class=\"submit\" value=\"Delete List\"></form></br></br>\n" +
                        "            </div>";
        
        for(int i=1;i<sList.length;i++){
            String[] sTask = sList[i].split(",");
            content += "                    <tr>\n";
            boolean done = sTask[sTask.length-1].equals("true");
            
            if(done){
                for(int x=0; x < sTask.length-1 ; x++)
                    content += "                        <td bgcolor=\"green\">" + sTask[x] + "</td>\n";
                
                content += "                        <td><form action=\"#\" method=\"post\"><input type=\"checkbox\" class=\"taskStat\" checked><input type=\"hidden\" name=\"done\" value=\""+ sList[0] + "," + sList[i] +"\"></form></td>\n" +
                    "                        <td><form action=\"#\" method=\"post\"><input type=\"hidden\" name=\"dTask\" value=\""+ sList[0] + "," + sList[i] +"\"><input type=\"submit\" class=\"submit\" value=\"Delete Task\"></form></td>\n" +
                    "                    </tr>\n";
            }
            else{
                for(int x=0; x < sTask.length-1 ; x++)
                    content += "                        <td>" + sTask[x] + "</td>\n";
            
                content += "                        <td><form action=\"#\" method=\"post\"><input type=\"checkbox\" class=\"taskStat\"><input type=\"hidden\" name=\"done\" value=\""+ sList[0] + "," + sList[i] +"\"></form></td>\n" +
                    "                        <td><form action=\"#\" method=\"post\"><input type=\"hidden\" name=\"dTask\" value=\""+ sList[0] + "," + sList[i] +"\"><input type=\"submit\" class=\"submit\" value=\"Delete Task\"></form></td>\n" +
                    "                    </tr>\n";
            }
        }
        
        return header + content + footer;
    }
    
}