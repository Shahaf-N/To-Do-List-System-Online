
package SRTDLSystem;

import java.io.*;
import java.util.Scanner;
import java.util.ArrayList;

public class ToDoListSystem {
    //class variables
    private User usr;
    private Scanner scan = new Scanner(System.in);
    
    //constructors
    public ToDoListSystem(User u) /*throws IOException,ClassNotFoundException*/{
        usr = u;
    }
    public static User addTask(User usr, String tlname,String tname,String desc,String deadline,int priority) throws IOException,ClassNotFoundException{
        boolean done = false;
        Task t = new Task(tname,desc,priority,deadline,done);
        if (usr.AddNewTask(tlname,t))
            return usr;
        return null;
    }
    
    public static void deleteList(User usr, String tlname) throws IOException,ClassNotFoundException{
        usr.DeleteList(tlname);
    }
    
    public static void deleteTask(User usr, String lname, String tname,String desc,String deadline,int priority, boolean done){
        usr.DeleteTask(lname,new Task(tname,desc,priority,deadline,done));
    }
    
    public static boolean addList(User usr, String tlname) throws IOException,ClassNotFoundException{
        if (!(usr.AddNewList(tlname))){
            return false;
        }
        return true;
    }
    
    public static void taskDone(User usr, String lname, String tname){
        usr.MarkTaskDone(lname, tname);
    }
}