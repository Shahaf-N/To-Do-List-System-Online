/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


if((window.location.pathname).split("/").pop() === "index.jsp"){
    let username = getCookie("Usr");
    if (username != "") {
        window.location.href = "./MainPage.jsp";
    }
}

var logout = document.querySelector("a.logout");
if (logout !== null)
    logout.addEventListener("click", deleteAllCookies);
var acceptP = document.querySelector("input[type=checkbox].policyCheck");
if(acceptP != null)
    acceptP.addEventListener("change", chmode);

var sbutton = document.querySelector("button[type=submit]");
if( sbutton != null)
    sbutton.addEventListener("click", clearData);

if((window.location.pathname).split("/").pop() === "ShowList.jsp"){
    let tasks=document.querySelectorAll("td form input[type=checkbox]");
    tasks.forEach(task => {task.addEventListener("change",function(){task.parentNode.submit();});});
}

    

//functions
function chmode(){
    var b = acceptP.parentNode.querySelector("input[type=submit]");
    b.disabled = !b.disabled;
}

function clearData(){
   let f = sbutton.parentNode.parentNode.querySelector("form");
   f.reset();
   if((window.location.pathname).split("/").pop() === "register.html")
       chmode();
}

function taskDone(){
    var taskfilds = this.parentNode.parentNode.querySelectorAll("td");
    if(this.checked)
        taskfilds.forEach(fild => {fild.style.color = "green";});
    else
        taskfilds.forEach(fild => {fild.style.color = "inherit";});
}

function deleteAllCookies() {
    const cookies = document.cookie.split(";");

    for (let i = 0; i < cookies.length; i++) {
        const cookie = cookies[i];
        const eqPos = cookie.indexOf("=");
        const name = eqPos > -1 ? cookie.substr(0, eqPos) : cookie;
        document.cookie = name + "=;expires=Thu, 01 Jan 1970 00:00:00 GMT";
    }
}

function getCookie(cname) {
  let name = cname + "=";
  let ca = document.cookie.split(';');
  for(let i = 0; i < ca.length; i++) {
    let c = ca[i];
    while (c.charAt(0) == ' ') {
      c = c.substring(1);
    }
    if (c.indexOf(name) == 0) {
      return c.substring(name.length, c.length);
    }
  }
  return "";
}