<%-- 
    Document   : menuVistas
    Created on : Oct 18, 2014, 8:03:43 AM
    Author     : DIMEI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

 <div id="menuCE"> 
            Opciones de busqueda:   
            <ul>
                <li onclick="contenido('contenido','consultas/encuestas/listar.jsp')">Por grupo </li>
                <li>buscar alumno <input id="txt_ncuenta" type="text" onclick="searchByAlumn(this)"> </li>
            <li onclick="contenido('contenido','consultas/encuestas/alumnos_faltantes.jsp')">Alumnos que no han contestado por encuesta  </li>
            <li>ver semestres anteriores  </li>
           </ul>
          
           </div>