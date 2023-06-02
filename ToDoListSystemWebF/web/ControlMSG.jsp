
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
        if (ck != null)
            for (int i=0;i<ck.length;i++)
                if (ck[i].getName().equals("Usr")){
                    def = ck[i].getValue().split(":")[0];
                    color = ck[i].getValue().split(":")[1];
                    logout = "<a href=\"index.html\" class=\"logout\">Logout</a>";
                }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <title>Servlet MainPage</title>
         <link rel="stylesheet" type="text/css" media="all" href="css/style.css">
         <meta charset="UTF-8">
         <meta name="viewport" content="width=device-width, initial-scale=1.0">
         <meta http-equiv="Expires" content=-10>
    </head>
    <body>
        <script src="js/code.js" defer></script>
        <header>
            <a href=".\\index.jsp"><img src="logo.png" height="50" width="50"></a>
             <h1>To Do List</h1>
             <h4 >Hello <span style="color: <%=color%>"> <%=def%> </span> <%=logout%> </h4>
        </header>
        <div class="controlmsg">
            <div class="cmsgheader">
                <h1>Control Messages</h1>
                <h2>you can see your messages down below:</h2>
            </div>
            <div class="cmsgfields">
                <p>Messages content</p>
                <%
            Cookie cok = null;
            if (ck != null)
                for (int i=0;i<ck.length;i++)
                    if (ck[i].getName().equals("err"))
                        cok = ck[i];
            if (cok != null) {%>
                <h3 style="color: red">Incorrect password - <a href="index.jsp">Home page</a></h3>
               <% cok.setValue("");
                cok.setMaxAge(0);
                response.addCookie(cok);
            }
            cok = null;
            if (ck != null)
                for (int i=0;i<ck.length;i++)
                    if (ck[i].getName().equals("display"))
                        cok = ck[i];
            if (cok != null){
                if (cok.getValue().equals("regT")){%>
                    <h3 style="color: green">Register success - <a href="MainPage.jsp">Continue to system</a></h3>
                <%}if (cok.getValue().equals("regF")){%>
                    <h3 style="color: red">Email already registred - <a href="index.jsp">Home page</a></h3>
                <%}if (cok.getValue().equals("ntT")){%>
                    <h3 style="color: green">Task added successfully, <a href="MainPage.jsp">back to main page</a>, <a href="NewTask.jsp">add more task</a></h3>
                <%}if (cok.getValue().equals("ntF")){%>
                    <h3 style="color: red">Task already exists, <a href="MainPage.jsp">back to main page</a>, <a href="NewTask.jsp">add more task</a></h3>
                <%}if (cok.getValue().equals("nlT")){%>
                    <h3 style="color: green">List added successfully, <a href="MainPage.jsp">back to main page</a>, <a href="NewTask.jsp">add tasks to this list</a></h3>
                <%}if (cok.getValue().equals("nlF")){%>
                    <h3 style="color: red">List already exists, <a href="MainPage.jsp">back to main page</a>, <a href="NewList.jsp">try again</a></h3>
                <%}cok.setValue("");
                cok.setMaxAge(0);
                response.addCookie(cok);
            }
            %>
            <div class="prevnext">
                <a href=""><- Previous page</a>
                <a href="">Next page -></a>
                </div>
            </div>
            </div>
            <footer>
                <p>Shahaf Nachum, Raz Chai | <a href="https://www.netanya.ac.il/" target="_blank">Netanya Academy College</a></p>
            </footer>
    </body>
</html>
