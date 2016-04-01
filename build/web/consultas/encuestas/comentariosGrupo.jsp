<%-- 
    Document   : comentarios
    Created on : Oct 8, 2014, 1:57:12 PM
    Author     : DIMEI
--%>

<jsp:useBean id="vComen" scope="session" class="ABC.ABCComentarios" />



<div id="accordion" style="width:60%">
		
<% int tipo = Integer.parseInt(request.getParameter("param"));
int grupo = Integer.parseInt(request.getParameter("grupo"));

String semestre = request.getParameter("sem");
if(tipo==1){ /*1 para encuestas de practicas, 2 para encuestas de servicio*/
%>

<%=vComen.l_comentariosPracticaxSemestre(semestre,grupo) %>  

<% }if(tipo==2){%>

<!--%=vComen.l_comentariosServicio()%-->  

<% }%>
</div>