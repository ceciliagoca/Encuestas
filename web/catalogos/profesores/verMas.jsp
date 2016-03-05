<%-- 
    Document   : verMas
    Created on : May 12, 2015, 12:33:45 AM
    Author     : DIMEI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean id="l_profes" scope="page" class="ABC.ABCProfesores" />
<jsp:useBean id="profesor" scope="page" class="entity.Profesor" />



<h1> Información de profesor</h1>

<% 
    profesor = l_profes.getProfesor(request.getParameter("param"));
%>
<div>
<form name="n_profesor" id="n_profesor">
                <table>
                    <tr>     <td>RFC(sin homoclave):</td> <td>  <%=profesor.getRfc()%> </td> </tr>
                    <tr>     <td>Profesor: </td> <td>  <%=profesor.getTitulo() +". " +  profesor.getNombre() + " " + profesor.getApeP() + " " + profesor.getApeM() %>    </td> </tr>
                    <tr>     <td>Email:</td> <td> <%=profesor.getCorreo()%>  </td> </tr>
                    <%if(profesor.getActivo()){ %>
                    <tr>     <td>Habilitado:</td> <td> Si </td> </tr>
                    <tr>     <td>Grupos actuales</td> <td> lista de grupos actuale </td> </tr>
                    <%}else{%>
                       <tr>     <td>Habilitado:</td> <td> No</td></tr>
                    <%}%>
                </table>
                
               
            </form>
                </div>