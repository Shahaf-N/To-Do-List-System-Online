
package SRTDLSystem;


import java.util.ArrayList;
import java.io.*;
import java.sql.*;
import java.time.Clock;
import java.util.Scanner;

public class Program {
    private static String path = "Users.txt";
    private static ArrayList<User> alu;
    //methods
    public static ArrayList<User> ReadFileU()throws Exception, ClassNotFoundException{
        /*File f = new File(path);
        ArrayList<User> al;
        if (!(f.exists())){
            FileOutputStream fo = new FileOutputStream(f);
            ObjectOutputStream out = new ObjectOutputStream(fo);
            out.writeObject(new ArrayList<User>());
            out.close();
            fo.close();
            al = new ArrayList<User>();
        }
        else{
            FileInputStream fi = new FileInputStream(f);
            ObjectInputStream in = new ObjectInputStream(fi);
            al = (ArrayList<User>)in.readObject();
            in.close();
            fi.close();
        }
        return al;*/
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        String urlc = "jdbc:derby://localhost:1527/MyDB";
        Connection cn = DriverManager.getConnection(urlc,"root","root");
        cn.setAutoCommit(false);
        Statement st1 = cn.createStatement();
        ResultSet udb = st1.executeQuery("select * from USERS");
        ArrayList<User> al = new ArrayList<User>();
        while (udb.next()){
            String gen = "female";
            if (udb.getBoolean("GENDER"))
                gen = "male";
            User u = new User(udb.getString("FNAME"),udb.getString("LNAME"),udb.getString("EMAIL"),udb.getString("PASSWORD"),udb.getDate("BDAY").toString(),udb.getInt("AGE") + "",gen);
            Statement st2 = cn.createStatement();
            ResultSet ldb = st2.executeQuery("select * from LISTS WHERE LISTS.USEREMAIL='"+u.GetEmail()+"'");
            while(ldb.next()){
                TaskList tl = new TaskList(ldb.getString("NAME"));
                Statement st3 = cn.createStatement();
                ResultSet tdb = st3.executeQuery("select * from TASKS WHERE TASKS.USEREMAIL='" + u.GetEmail() + "' AND TASKS.LISTNAME='"+ldb.getString("NAME")+"'");
                while(tdb.next()){
                    Task t = new Task(tdb.getString("NAME"),tdb.getString("DESCRIPTION"),tdb.getInt("PRIORITY"),tdb.getDate("DEADLINE").toString(),tdb.getBoolean("FLAG"));
                    tl.AddTask(t);
                }
                u.AddList(tl);
            }
            al.add(u);
        }
        //cn.close();
        return al;
    }
    public static void WriteFileU(ArrayList<User> al)throws Exception, ClassNotFoundException{
        /*FileOutputStream fo = new FileOutputStream("Users.txt");
        ObjectOutputStream out = new ObjectOutputStream(fo);
        out.writeObject(al);
        fo.close();
        out.close();*/
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        String urlc = "jdbc:derby://localhost:1527/MyDB";
        Connection cn = DriverManager.getConnection(urlc,"root","root");
        Statement st = cn.createStatement();
        st.executeUpdate("DELETE FROM USERS");
        st.executeUpdate("DELETE FROM LISTS");
        st.executeUpdate("DELETE FROM TASKS");
        for (User u : al){
            st.executeUpdate("INSERT INTO USERS VALUES ('"+u.getFname()+"','"+u.getLname()+"','"+u.GetEmail()+"','"+u.GetPass()+"','"+u.getBdate()+"',"+u.getAge()+","+u.getGender()+")");
            ArrayList<TaskList> ali = u.getLists();
            for (TaskList tl : ali){
                st.executeUpdate("INSERT INTO LISTS VALUES ('"+tl.getName()+"','"+u.GetEmail()+"')");
                ArrayList<Task> alt = tl.getTasks();
                for (Task ts : alt){
                    st.executeUpdate("INSERT INTO TASKS VALUES ('"+ts.getName()+"','"+ts.getDescription()+"',"+ts.getArgency()+",'"+ts.getDeadline()+"',"+ts.isDone()+",'"+tl.getName()+"','"+u.GetEmail()+"')");
                }
            }
        }
        //cn.close();
    }
    
    public static User addUsr(User u) throws Exception, ClassNotFoundException{//adds new usr to the database
        alu = ReadFileU();
        if (alu == null)
            alu = new ArrayList<User>();
        if (alu.contains(u)) {
            WriteFileU(alu);
            return null;
        }
        alu.add(u);
        WriteFileU(alu);
        return u;
    }
    public static User updateUsrInFile(User u)throws Exception, ClassNotFoundException{
        alu = ReadFileU();
        if (alu == null)
            alu = new ArrayList<User>();
        alu.remove(u);
        alu.add(u);
        WriteFileU(alu);
        return u;
    }
    
    public static User searchUsr(String email, String pass) throws Exception, ClassNotFoundException{//serch usr and return him. if dose not exist returns null
        alu = ReadFileU();
        if (alu == null)
            alu = new ArrayList<User>();
        User temp1 = null;
        for (int i=0;i<alu.size();i++){
            if (alu.get(i).GetEmail().equals(email) && alu.get(i).GetPass().equals(pass)){
                temp1 = alu.get(i);
                break;
            }
        }
        WriteFileU(alu);
        return temp1;
    }
    
    public static User searchUsrByEmail(String email) throws Exception, ClassNotFoundException{//serch usr and return him. if dose not exist returns null
        alu = ReadFileU();
        if (alu == null)
            alu = new ArrayList<User>();
        User temp1 = null;
        for (int i=0;i<alu.size();i++){
            if (alu.get(i).GetEmail().equals(email)){
                temp1 = alu.get(i);
                break;
            }
        }
        WriteFileU(alu);
        return temp1;
    }
    
    public static User login(String usrEmail,String usrPass)throws Exception, ClassNotFoundException{
        User u = searchUsr(usrEmail, usrPass);
        if (u==null)
            return null;
        return u;
    }
    
    public static User register(String fname,String lname,String email,String pass,String bd,String a,String g)throws Exception, ClassNotFoundException{
        if(searchUsr(email, pass) != null){
            return null;
        }
        else{
            return addUsr(new User(fname, lname, email, pass,bd,a,g));
        }
    }
                   
}
