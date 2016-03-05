<%-- 
    Document   : inicioSesion
    Created on : 3/12/2013, 09:04:12 AM
    Author     : Cecilia
--%>

<%@page import="ABC.ABCUsuarios"%>
<jsp:useBean id="cuesUs" scope="session" class="entity.Usuario" />

<% 
   
if(cuesUs.getTipo()==0){
 ABC.ABCUsuarios user = new ABCUsuarios();
String name =  request.getParameter("name");
String passwd = request.getParameter("passwd");
%>



<%
user.autenticar(name, passwd);
if(user.usuario!=null){
cuesUs.setTipo(user.usuario.getTipo());
%>

<jsp:setProperty name="cuesUs" property="id" value="<%=user.usuario.getId()%>" />
<jsp:setProperty name="cuesUs" property="user" value="<%=user.usuario.getUser()%>"/>    
<jsp:setProperty name="cuesUs" property="tipo" value="<%=user.usuario.getTipo()%>" />    ´


<%=cuesUs.getTipo()%>
<%
}
else{%>
   <%=0%> 
<%}
}
%>

