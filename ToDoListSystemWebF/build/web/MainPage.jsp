
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
        Cookie ck[] = request.getCookies();
        String def="Guest";
        String color="";
        String logout="";
        boolean temp = false;
        if (ck != null)
            for (int i=0;i<ck.length;i++){
                if (ck[i].getName().equals("Usr")){
                    def = ck[i].getValue().split(":")[0];
                    color = ck[i].getValue().split(":")[1];
                    temp = true;
                    logout = "<a href=\"index.jsp\" class=\"logout\">Logout</a>";
                }
                if (ck[i].getName().equals("lname")){
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
            <title>Servlet MainPage</title>
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
            <div class="mpage">
                <div class="mpageh">
                    <h1>Main Page</h1></br>
                    <h3>You can use the pages below for your needs</h3></br>
                </div>
                <div class="mpageb">
                    <h3><a href=".\\NewTask.jsp">To add a new task</a></br></h3>
                    <h3><a href=".\\NewList.jsp">To add a new list of task's</a></br></h3>
                    <h3> <a href=".\\ShowList.jsp">To view all task's</a></br></h3>
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
%>