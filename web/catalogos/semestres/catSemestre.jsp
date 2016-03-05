<%-- 
    Document   : catProfesores
    Created on : Apr 24, 2015, 12:44:10 AM
    Author     : DIMEI
--%>

<%@page import="entity.Semestre"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entity.Profesor"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="semestre" scope="session" class="ABC.ABCSemestre" />
<jsp:useBean id="l_profes" scope="page" class="ABC.ABCProfesores" />
<jsp:useBean id="profesor" scope="page" class="entity.Profesor" />
<!DOCTYPE html>

<h1 style="font-size: larger ; font-weight: bolder; color: #1966A8">Semestres</h1>
<h1 style="color: #1966A8; font-size: larger">
  <% if (semestre.consultarSemestreActual().equals(""))  { %> 

 <B>Semestre actual:</b>  No hay ningun semestre en curso en este momento, puede explorar los semestres anteriores con ayuda del menú, <br>o generar un nuevo semestre para el proximo periodo 
<%}else{%> <%=  "<B>Semestre actual:</b>" + semestre.getCurrent() %> <% } %> 
        </h1> 
        <div class="datagrid">
<table>
<thead><tr><th> Semestres </th><th > Inicio </th><th> Fin</th></tr></thead>
<tfoot><tr><td colspan="3">
            <div id="paging"> <ul>
                    <li><img style="cursor:pointer;" width="20" src="imgs/info.png" onclick="showInfo('semestre');"> 
                        
                    </li></ul>
            </div>
        </td></tr></tfoot>

     <%=semestre.listarSemestresCatalgo() %>

<tbody>



</tbody>
</table></div>
