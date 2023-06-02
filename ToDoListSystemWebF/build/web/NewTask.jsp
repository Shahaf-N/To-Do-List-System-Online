
<%@page import="java.io.IOException"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="javax.servlet.ServletException"%>
<%@page import="javax.servlet.http.Cookie"%>
<%@page import="javax.servlet.http.HttpServlet"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<%@page import="SRTDLSystem.*"%>
<%@page import="javax.servlet.RequestDispatcher"%>

<%
    if (request.getMethod().equals("GET")) {
        Cookie ck[] = request.getCookies();
        boolean temp = false;
        String def="Guest";
        String color="";
        String lname="";
        String logout="";
        if (ck != null)
            for (int i=0;i<ck.length;i++){
                if (ck[i].getName().equals("Usr")){
                    def = ck[i].getValue().split(":")[0];
                    color = ck[i].getValue().split(":")[1];
                    temp=true;
                    logout = "<a href=\"index.jsp\" class=\"logout\">Logout</a>";
                }
                if (ck[i].getName().equals("lname")){
                    lname = ck[i].getValue();
                    ck[i].setMaxAge(0);
                    ck[i].setValue("");
                    response.addCookie(ck[i]);
                }
            }
        if (temp){
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
    <html>
        <head>
            <title>To Do List System</title>
            <link rel="stylesheet" type="text/css" media="all" href="css/style.css">
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <meta http-equiv="Expires" content=-10>
        </head>
        <body>
            <script src="js/code.js" defer></script>
            <header>
                <a href=".\\MainPage.jsp"><img src="logo.png" height="50" width="50"></a>
                <h1>To Do List</h1>
                <h4>Hello <span style="color: <%=color%>"> <%=def%> </span> <%=logout%> </h4>
            </header>
            <div class="boxwrapper">
                <div class="boxheader">
                    <h1>New task</h1>
                    <h2>New task adder:</h2>
                    <h3>Please enter details:</h3>
                </div>
                <div class="boxfields">
                    <form action="#" id="ntform" method="post">
                        <label for="lname">List name:</label>
                        <input type="text" id="lname" name="lname" value="<%=lname%>"><br><br>
                        <label for="lname">Task name:</label>
                        <input type="text" id="lname" name="tname"><br><br>
                        <label for="lname">Description:</label>
                        <input type="text" id="lname" name="desc" maxlength="100"><br><br>
                        <label for="lname">Priority:</label>
                        <input type="radio" id="1" name="pr" value="1" checked><label for="1">1</label>
                        <input type="radio" id="2" name="pr" value="2" checked><label for="2">2</label>
                        <input type="radio" id="3" name="pr" value="3" checked><label for="3">3</label><br><br>
                        <label for="lname">Deadline:</label>
                        <input type="date" id="dat" name="tdate" value="2018-07-22" min="2018-01-01" max="2018-12-31"><br><br>
                        <input type="submit" class="submit" value="submit">
                    </form>
                </div>
            </div>
            <footer>
                <p>Shahaf Nachum, Raz Chai | <a href="https://www.netanya.ac.il/" target="_blank">Netanya Academy College</a></p>
            </footer>
        </body>
    </html>
    <%
        }
        else{
            response.sendRedirect("index.jsp");
        }
}
else{
        Cookie ck[] = request.getCookies();
        boolean tem=false;
        if (ck != null)
            for (int i=0;i<ck.length;i++)
                if (ck[i].getName().equals("Usr"))
                    tem=true;
        String em = null;
        String pass = null;
        Cookie c=null;
        if (tem){
            for (int i=0;i<ck.length;i++)
                if (ck[i].getName().equals("Usr")){
                    em = ck[i].getValue().split(":")[2];
                    pass = ck[i].getValue().split(":")[3];
                    c=ck[i];
                }
            User u = null;
            try{
                u = Program.login(em, pass);
            }
            catch(ClassNotFoundException e){}
            if (u==null){
                c.setMaxAge(0);
                response.addCookie(c);
                response.sendRedirect("index.jsp");
            }
            try{
                u = ToDoListSystem.addTask(u, request.getParameter("lname"), request.getParameter("tname"), request.getParameter("desc"), request.getParameter("tdate"), Integer.parseInt(request.getParameter("pr")));
                if (u!=null){
                    Program.updateUsrInFile(u);
                    response.addCookie(new Cookie("display","ntT"));
                    response.sendRedirect("ControlMSG.jsp");
                }
                else{
                    response.addCookie(new Cookie("display","ntF"));
                    response.sendRedirect("ControlMSG.jsp");
                }
            }
            catch(Exception ClassNotFoundException){
                System.out.print("shit11");
            }
            
        }
        
    }
    %>
