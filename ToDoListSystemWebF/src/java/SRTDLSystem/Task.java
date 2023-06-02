
package SRTDLSystem;
import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author Shahaf Nachum,Raz Chai
 */
public class Task implements Serializable,Comparable{
  //member variables
    private String name,description,deadline;
    private int argency;
    private boolean done;
    
    //constructors
    public Task(String name,String description,int argency,String deadline,boolean done){
        this.name = name;
        this.description = description;
        this.argency = argency ;
        this.deadline = deadline;
        this.done = done;
    }
    public boolean SameName(String tn){
        return name.equals(tn);
    }
    public void DoneT(){
        done = !(done);
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public String getDeadline() {
        return deadline;
    }

    public int getArgency() {
        return argency;
    }

    public boolean isDone() {
        return done;
    }
    
    
    //toString override
    @Override
    public String toString(){
        return name + "," + description+ "," + argency + "," + deadline + "," + done + "\n";
    }
    
    //equals override
    @Override
    public boolean equals(Object o){
        if(o instanceof Task){
            Task t = (Task)o;
            return (t.name.equals(this.name) && t.description.equals(this.description) && t.argency == this.argency && t.deadline.equals(this.deadline) && t.done == this.done);   
        }
        else
            return false;
    }  

    @Override
    public int compareTo(Object o) {
        if (o instanceof Task){
            Task t1 = (Task)o;
            return this.argency - t1.argency;
        }
        else
            return -1;
    }
}
