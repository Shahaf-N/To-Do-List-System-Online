
package SRTDLSystem;

import java.io.*;
import java.util.ArrayList;
import java.util.Collections;


public class TaskList implements Serializable{
    //Variables
    private ArrayList<Task> tl;
    private String name;
    
    //Constructors
    public TaskList(String n){
        tl = new ArrayList<Task>();
        name = n;
    }
    public TaskList(ArrayList<Task> temp){
        tl = temp;
    }
    public String getName(){
        return name;
    }
    //Methods
    public void AddTask(Task t){
        tl.add(t);
    }
    
    public boolean ContainTask(Task t){
        return tl.contains(t);
    }
    
    public void removeTask(Task t){
        tl.remove(t);
    }
     public ArrayList<Task> getTasks(){
        return tl;
    }
    
    @Override
    public boolean equals(Object o){
         if(o instanceof TaskList){
            TaskList t = (TaskList)o;
            return name.equals(t.name);
        }
        else
            return false;
    }
    @Override
    public String toString(){
        String temp=name + "\n";
        Collections.sort(tl);
        for (Task t : tl)
            temp += t.toString();
        return temp;
    }
    public boolean TaskDone(String tna){
        for(Task temp : tl){
            if (temp.SameName(tna)){
                temp.DoneT();
                return true;
            }
        }
                    
        return false;
    }
}
