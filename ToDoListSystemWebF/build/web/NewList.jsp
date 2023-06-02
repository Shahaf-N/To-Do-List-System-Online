
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
        String logout="";
        if (ck != null)
            for (int i=0;i<ck.length;i++)
                if (ck[i].getName().equals("Usr")){
                    def = ck[i].getValue().split(":")[0];
                    color = ck[i].getValue().split(":")[1];
                    temp=true;
                    logout = "<a href=\"index.jsp\" class=\"logout\">Logout</a>";
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
                    <h1>New list</h1>
                    <h2>New list adder:</h2>
                    <h3>Please enter details:</h3>
                </div>
                <div class="boxfields" id="container">
                    <form action="" method="post">
                        <label for="lname">List name:</label>
                        <input type="text" id="lname" name="lname"><br><br>
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
else {
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
                    c = ck[i];
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
                if (ToDoListSystem.addList(u, request.getParameter("lname"))){
                    Program.updateUsrInFile(u);
                    response.addCookie(new Cookie("lname",request.getParameter("lname")));
                    response.addCookie(new Cookie("display","nlT"));
                    response.sendRedirect("ControlMSG.jsp");
                }
                else{
                    response.addCookie(new Cookie("display","nlF"));
                    response.sendRedirect("ControlMSG.jsp");
                }
            }
            catch(Exception ClassNotFoundException){
                System.out.print("shit");
            }
        }
}
    %>
