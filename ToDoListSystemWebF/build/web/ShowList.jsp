
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
        Cookie c=null;
        String name="",color="",logout="";
        boolean tem=true;
        if (ck != null)
            for (int i=0;i<ck.length;i++)
                if (ck[i].getName().equals("Usr"))
                    tem=false;
        String em = null;
        String pass = null;
        if (tem){
            response.sendRedirect("index.jsp");
        }
        else{
            for (int i=0;i<ck.length;i++)
                if (ck[i].getName().equals("Usr")){
                    name = ck[i].getValue().split(":")[0];
                    color = ck[i].getValue().split(":")[1];
                    em = ck[i].getValue().split(":")[2];
                    pass = ck[i].getValue().split(":")[3];
                    c=ck[i];
                    logout = "<a href=\"index.jsp\" class=\"logout\">Logout</a>";
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
            try{%>
                <%=u.show(name,color,logout)%>
            <%}
            catch(Exception ClassNotFoundException){
                System.out.print("shit");
            }
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
                if(request.getParameter("dTask") != null){
                    String[] params=request.getParameter("dTask").split(",");
                    ToDoListSystem.deleteTask(u,params[0],params[1],params[2],params[4],Integer.parseInt(params[3]),Boolean. parseBoolean(params[5]));
                    Program.updateUsrInFile(u);
                    response.sendRedirect("ShowList.jsp");
                }
                else if(request.getParameter("dList") != null){
                    ToDoListSystem.deleteList(u,request.getParameter("dList"));
                    Program.updateUsrInFile(u);
                    response.sendRedirect("ShowList.jsp");
                }
                else if(request.getParameter("done") != null){
                    String[] params=request.getParameter("done").split(",");
                    ToDoListSystem.taskDone(u,params[0],params[1]);
                    Program.updateUsrInFile(u);
                    response.sendRedirect("ShowList.jsp");
                }
            }
            catch(Exception ClassNotFoundException){
                System.out.print("shit");
            }
        }
    }
%>