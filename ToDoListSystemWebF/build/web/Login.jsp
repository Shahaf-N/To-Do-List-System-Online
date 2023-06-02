
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
            <title>Servlet Login</title>
                <link rel="stylesheet" type="text/css" media="all" href="css/style.css">
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <meta http-equiv="Expires" content=-10>
        </head>
        <body>
            <header>
                <a href=".\\index.jsp"><img src="logo.png" height="50" width="50"></a>
                <h1>To Do List</h1>
                <h4>Hello Guest</h4>
            </header>
            <div class="boxwrapper">
                <div class="boxheader">
                    <h1>Login</h1>
                    <h3>Please enter your personal details:</h3>
                </div>
                <div class="boxfields" id="container">
                    <form action="" method="post">
                        <label for="lname">Email:</label>
                        <input type="email" id="Email" name="Email" required><br><br>
                        <label for="lname">Password:</label>
                        <input type="password" id="pass" name="pass" required><br>
                        <a href=".\\index.jsp" title="It's your problem">Forgot Password</a><br><br>
                        <button class="submit" type="submit" name="login" id="login" value="l">Login</button>
                        <input type="submit" value="log" name="log" hidden>
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
            Cookie ck[] = request.getCookies();
            boolean tem=true;
        if (ck != null)
            for (int i=0;i<ck.length;i++)
                if (ck[i].getName().equals("Usr"))
                    tem=false;
        if (tem){
            String em = request.getParameter("Email");
            String pass = request.getParameter("pass");
            User u = null;
            try{
                u = Program.login(em, pass);
            }
            catch(ClassNotFoundException e){}
            if (u==null){
                //continue incorrect
                Cookie c = new Cookie("err","incpass");
                response.addCookie(c);
                response.sendRedirect("ControlMSG.jsp");
            }
            else{
                //logged correctly
                Cookie c = new Cookie("Usr",u.CreateUserCookie());
                response.addCookie(c);
                response.sendRedirect("MainPage.jsp");
            }
        }
        else{
            response.sendRedirect("Login.jsp");
        }
}
%>
