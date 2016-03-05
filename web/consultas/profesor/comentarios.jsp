<%-- 
    Document   : comentarios
    Created on : Oct 8, 2014, 1:57:12 PM
    Author     : DIMEI
--%>



<jsp:useBean id="vComment" scope="session" class="ABC.ABCComentarios" />

<jsp:useBean id="cuesUs" scope="session" class="entity.Usuario" />

<div id="accordion" style="width:60%">
		
		
<% int tipo = Integer.parseInt(request.getParameter("param"));
if(tipo==1){ /*1 para encuestas de practicas, 2 para encuestas de servicio*/
%>

 <%=vComment.l_comentariosPracticas(cuesUs.getUser())%>

<% }if(tipo==2){%>

 <%=vComment.l_comentariosServicio(cuesUs.getUser())%>

<% }%>
   


</div>