
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
        boolean temp = true;
        if (ck!=null)
            for (int i=0;i<ck.length;i++)
                if (ck[i].getName().equals("Usr"))
                    temp = false;
        if (ck == null || temp){
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
    <html>
        <head>
            <title>Servlet Register</title>
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
                <h4>Hello Guest</h4>
            </header>
                <div class="boxwrapper">
                    <div class="boxheader">
                        <h1>Register</h1>
                        <h3>Please enter your personal details:</h3>
                    </div>
                    <div class="boxfields">
                        <form action="" method="post">
                            <label>First Name:</label>
                            <input type="text" id="Fname" name="Fname"><br><br>
                            <label>Last Name:</label>
                            <input type="text" id="Lname" name="Lname"><br><br>
                            <label>Email:</label>
                            <input type="email" id="Email" name="Email" required><br><br>
                            <label>Password:</label>
                            <input type="password" id="pass" name="pass" required><br><br>
                            <label>Date of birth:</label>
                            <input type="date" id="dat" name="tdate" value="2018-07-22" min="1900-01-01" max="2022-12-31"><br><br>
                            <label>Age:</label>
                            <input type="number" id="age" name="age" min="10" max="120"><br><br>
                            <label>Gender:</label>
                            <input type="radio" id="male" name="gender" value="male" checked><label for="1">Male</label>
                            <input type="radio" id="female" name="gender" value="female"><label for="2">Female</label><br><br>
                            <input type="checkbox" class="policyCheck" value="accept"><label for="2">"I accept the privacy police"</label><br><br>
                            <input type="submit" value="Register" class="submit" name="register" disabled>
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
            response.sendRedirect("MainPage.jsp");
        }
}
else{

        User u=null;
        try{
            if (Program.searchUsrByEmail(request.getParameter("Email"))==null){
                u = Program.register(request.getParameter("Fname"),request.getParameter("Lname"),request.getParameter("Email"),request.getParameter("pass"),request.getParameter("tdate"),request.getParameter("age"),request.getParameter("gender"));
                Cookie co = new Cookie("Usr",u.CreateUserCookie());
                response.addCookie(co);
                response.addCookie(new Cookie("display","regT"));
            }
            else{
                response.addCookie(new Cookie("display","regF"));
            }
            response.sendRedirect("ControlMSG.jsp");
        }catch(ClassNotFoundException e){}
}
    %>
