<%@page import="entity.Preguntas"%>
<%@page import="java.util.Iterator"%>
<%@page import="entity.Encuesta"%>
<%@ page session="true" %>
<%@page import="entity.Usuario"%>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<jsp:useBean id="practica" scope="session" class="ABC.ABCEncuestas" />
<jsp:useBean id="pregunta" scope="session" class="entity.Preguntas" />

<body>
    
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<jsp:useBean id="alumno" scope="page" class="ABC.ABCAlumnos" />
        <%/*alumno.getAlumno(cuesUs.getUser());
      
        encuesta.setIdAlumno(cuesUs.getUser());
        encuesta.setIdPractica(Integer.parseInt(request.getParameter("param")));
        practica.gettPracticas(Integer.parseInt(request.getParameter("prac")));
        * */
            
            practica.getInfo(Integer.parseInt(request.getParameter("param")));
            Iterator iter = practica.encuesta.getL().iterator();
       
        %>
  
        
        <img id="btn_salir" src="imgs/cross.png" onclick="$('#showEncuesta').hide();">

<table width="925" height="217">
  <tr>
    <td width="161" height="109"><center><img src="http://www.ingenieria.unam.mx/imagenes/escudo_fi_color_dibujo_354x425_trans.gif" alt="" name="irc_mi" width="115" height="137" align="top" id="irc_mi" /></center></td>
    <td width="429" class="centrado" style="text-align: center; font-size: larger; font-weight: bold;">Encuesta de evaluación de la práctica</td>
    <td width="313" height="109" style="text-align:right"> <table width="313" >
      <tr>
        <td width="150">Código</td>
        <td  class="centradoForm">FODO-31</td>
      </tr>
      <tr>
        <td>Versión </td>
        <td  class="centradoForm">1</td>
      </tr>
      <tr>
        <td height="32">Página</td>
        <td  class="centradoForm" >41275</td>
      </tr>
      <tr class="sombreado">
        <td>Sección ISO</td>
        <td  class="centradoForm" >7.5.1</td>
      </tr>
      <tr>
        <td>Fecha de emisión </td>
        <td  class="centradoForm" >02 de agosto de 2013</td>
      </tr>
    </table></td>
  </tr>
  <tr>
      <td height="23" colspan="3" style="text-align: center; font-size: larger; font-weight: bold;">Secretaria/División: División de Ingeniería Mecánica e Industrial  Área/Departamento: Laboratorio de automatización Industrial </td>
  </tr>
  <tr>
    <td height="75" colspan="3"><p>ESTIMADO ALUMNO: Con la finalidad de mejorar el servicio que te brinda el laboratorio, te solicitamos  responder verazmente la siguiente encuesta y proporcionar cualquier comentario adicional que consideres relevante.</p>
      <table width="892" >
        <tr>
          <td width="292">Alumno: <%=practica.practica.getNombreAlumno()%> </td>
          <td width="243">Grupo: <%=practica.practica.getGrupo() %> </td>
          <td width="341">Brigada: <%=practica.practica.getBrigada() %> </td>
        </tr>
        <tr>
             
          <td>Práctica: <%=practica.practica.getNombre() %></td>
          <td>Fecha:<%=practica.practica.getFecha() %> </td>
          <td>Semestre:<%=practica.practica.getSemestre() %> </td>
        </tr>
      </table>
    <p>&nbsp;</p></td>
  </tr>
</table>
<table width="925" >
  <tr class="centradoForm">
    <td width="560"><p>Responde según la siguiente escala:
    <br>&nbsp;10: Muy buena&nbsp; &nbsp;&nbsp; 8:Buena
    <br>&nbsp;&nbsp;6: Regular &nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; 5:Mala</p></td>
    <td width="22" class="centradoForm"></td>
    <td width="22" class="centradoForm"></td>
    <td width="22" class="centradoForm"></td>
    <td width="22" class="centradoForm"></td>
    <td  width="417" colspan="2">En caso de que no haya sido de tu completa satisfacción, requerimos nos ayudes a identificar los aspectos a mejorar en cada rubro, utilizando los siguientes espacios.</td>
    <td width="22" class="centradoForm"></td>
  
 </tr>
        <tr> <td colspan="6" class="sombreado">A.- DESARROLLO DE LA PRACTICA</td> </tr>
        <tr> <td></td>
        <td  class="centradoForm">10</td> <td class="centradoForm">8</td> <td  class="centradoForm">6</td> <td class="centradoForm">5</td>
        <td></td>
        <td></td>
        </tr>

        <tr>
        <td>1.- ¿Se te entregó el material necesario y suficiente para la realización de la práctica?</td>
                                        
            <%pregunta = (Preguntas)iter.next();
            if(pregunta.getOpcion()==10 ){%>
            <td><input class="check" type="radio" disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio" disabled></td>
            <%}%>
            <% if(pregunta.getOpcion()==8 ){%>
            <td><input class="check" type="radio" disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio" disabled></td>
            <%}%>
            <% if(pregunta.getOpcion()==6 ){%>
            <td><input class="check" type="radio" disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio"  disabled></td>
            <%}%>
            <% if(pregunta.getOpcion()==5 ){%>
            <td><input class="check" type="radio"  disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio"  disabled></td>
            <%}%>
            <td colspan="2"><textarea name="c_o_1" cols="56" disabled> <%=(pregunta.getComentario()==null)?" " : pregunta.getComentario()%> </textarea></td>
            <td class="c_error" id="m_o_1"> </td> 
            </tr>
        
        <tr>
        <td>2.- La disponibilidad del material y equipo para realizar la práctica fue</td>
        
         <%pregunta = (Preguntas)iter.next();
            if(pregunta.getOpcion()==10 ){%>
            <td><input class="check" type="radio" disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio" disabled></td>
            <%}%>
            <% if(pregunta.getOpcion()==8 ){%>
            <td><input class="check" type="radio" disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio" disabled></td>
            <%}%>
            <% if(pregunta.getOpcion()==6 ){%>
            <td><input class="check" type="radio" disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio"  disabled></td>
            <%}%>
            <% if(pregunta.getOpcion()==5 ){%>
            <td><input class="check" type="radio"  disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio"  disabled></td>
            <%}%>
            <td colspan="2"><textarea name="c_o_1" cols="56" disabled> <%=(pregunta.getComentario()==null)?" " : pregunta.getComentario()%> </textarea></td>
            <td class="c_error" id="m_o_1"> </td> 
        </tr>
            


        <tr><td>3.- ¿El profesor dio a conocer el objetivo al inicio de la práctica?</td>
                    <%pregunta = (Preguntas)iter.next();
            if(pregunta.getOpcion()==10 ){%>
            <td><input class="check" type="radio" disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio" disabled></td>
            <%}%>
            <% if(pregunta.getOpcion()==8 ){%>
            <td><input class="check" type="radio" disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio" disabled></td>
            <%}%>
            <% if(pregunta.getOpcion()==6 ){%>
            <td><input class="check" type="radio" disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio"  disabled></td>
            <%}%>
            <% if(pregunta.getOpcion()==5 ){%>
            <td><input class="check" type="radio"  disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio"  disabled></td>
            <%}%>
            <td colspan="2"><textarea name="c_o_1" cols="56" disabled> <%=(pregunta.getComentario()==null)?" " : pregunta.getComentario()%> </textarea></td>
            <td class="c_error" id="m_o_1"> </td> 
        </tr>
            
        <tr><td>4.- El funcionamiento del equipo para realizar la práctica fue</td>
            <%pregunta = (Preguntas)iter.next();
            if(pregunta.getOpcion()==10 ){%>
            <td><input class="check" type="radio" disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio" disabled></td>
            <%}%>
            <% if(pregunta.getOpcion()==8 ){%>
            <td><input class="check" type="radio" disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio" disabled></td>
            <%}%>
            <% if(pregunta.getOpcion()==6 ){%>
            <td><input class="check" type="radio" disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio"  disabled></td>
            <%}%>
            <% if(pregunta.getOpcion()==5 ){%>
            <td><input class="check" type="radio"  disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio"  disabled></td>
            <%}%>
            <td colspan="2"><textarea name="c_o_1" cols="56" disabled> <%=(pregunta.getComentario()==null)?" " : pregunta.getComentario()%> </textarea></td>
            <td class="c_error" id="m_o_1"> </td> 
        </tr>  
         <tr> <td colspan="6" class="sombreado">B.- PROFESOR</td> </tr>

        <tr>
            <td></td>
            <td  class="centradoForm">10</td> <td class="centradoForm">8</td> <td  class="centradoForm">6</td> <td class="centradoForm">5</td>
            <td></td>
            <td></td>
        </tr>

        <tr> <td>5.- La explicación de los conceptos previos a la páctica fue</td>
            <%pregunta = (Preguntas)iter.next();
            if(pregunta.getOpcion()==10 ){%>
            <td><input class="check" type="radio" disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio" disabled></td>
            <%}%>
            <% if(pregunta.getOpcion()==8 ){%>
            <td><input class="check" type="radio" disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio" disabled></td>
            <%}%>
            <% if(pregunta.getOpcion()==6 ){%>
            <td><input class="check" type="radio" disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio"  disabled></td>
            <%}%>
            <% if(pregunta.getOpcion()==5 ){%>
            <td><input class="check" type="radio"  disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio"  disabled></td>
            <%}%>
            <td colspan="2"><textarea name="c_o_1" cols="56" disabled> <%=(pregunta.getComentario()==null)?" " : pregunta.getComentario()%> </textarea></td>
            <td class="c_error" id="m_o_1"> </td>
        <tr> <td>6.- Las indicaciones para el desarrollo de la práctica fueron</td>
            <%pregunta = (Preguntas)iter.next();
            if(pregunta.getOpcion()==10 ){%>
            <td><input class="check" type="radio" disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio" disabled></td>
            <%}%>
            <% if(pregunta.getOpcion()==8 ){%>
            <td><input class="check" type="radio" disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio" disabled></td>
            <%}%>
            <% if(pregunta.getOpcion()==6 ){%>
            <td><input class="check" type="radio" disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio"  disabled></td>
            <%}%>
            <% if(pregunta.getOpcion()==5 ){%>
            <td><input class="check" type="radio"  disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio"  disabled></td>
            <%}%>
            <td colspan="2"><textarea name="c_o_1" cols="56" disabled> <%=(pregunta.getComentario()==null)?" " : pregunta.getComentario()%> </textarea></td>
            <td class="c_error" id="m_o_1"> </td>
        <tr><td>7.- La aclaracion de dudas durante la práctica fue</td>  
            <%pregunta = (Preguntas)iter.next();
            if(pregunta.getOpcion()==10 ){%>
            <td><input class="check" type="radio" disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio" disabled></td>
            <%}%>
            <% if(pregunta.getOpcion()==8 ){%>
            <td><input class="check" type="radio" disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio" disabled></td>
            <%}%>
            <% if(pregunta.getOpcion()==6 ){%>
            <td><input class="check" type="radio" disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio"  disabled></td>
            <%}%>
            <% if(pregunta.getOpcion()==5 ){%>
            <td><input class="check" type="radio"  disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio"  disabled></td>
            <%}%>
            <td colspan="2"><textarea name="c_o_1" cols="56" disabled> <%=(pregunta.getComentario()==null)?" " : pregunta.getComentario()%> </textarea></td>
            <td class="c_error" id="m_o_1"> </td>


        <tr><td colspan="6" class="sombreado">C.- INSTALACIONES</td>  </tr>

        <tr>
        <td></td>
        <td  class="centradoForm">10</td> <td class="centradoForm">8</td> <td  class="centradoForm">6</td> <td class="centradoForm">5</td>
        <td></td>
        <td></td>
        </tr>

        <tr>
        <tr> <td><p>8.- ¿Se cuenta con las mesas y sillas adecuadas para la realización de  la práctica?</p></td>
            <%pregunta = (Preguntas)iter.next();
            if(pregunta.getOpcion()==10 ){%>
            <td><input class="check" type="radio" disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio" disabled></td>
            <%}%>
            <% if(pregunta.getOpcion()==8 ){%>
            <td><input class="check" type="radio" disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio" disabled></td>
            <%}%>
            <% if(pregunta.getOpcion()==6 ){%>
            <td><input class="check" type="radio" disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio"  disabled></td>
            <%}%>
            <% if(pregunta.getOpcion()==5 ){%>
            <td><input class="check" type="radio"  disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio"  disabled></td>
            <%}%>
            <td colspan="2"><textarea name="c_o_1" cols="56" disabled> <%=(pregunta.getComentario()==null)?" " : pregunta.getComentario()%> </textarea></td>
            <td class="c_error" id="m_o_1"> </td>
        <tr><td>9.- La funcionalidad de las instalaciones (eléctricas, neumática y de iluminación) fue </td>
            <%pregunta = (Preguntas)iter.next();
            if(pregunta.getOpcion()==10 ){%>
            <td><input class="check" type="radio" disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio" disabled></td>
            <%}%>
            <% if(pregunta.getOpcion()==8 ){%>
            <td><input class="check" type="radio" disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio" disabled></td>
            <%}%>
            <% if(pregunta.getOpcion()==6 ){%>
            <td><input class="check" type="radio" disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio"  disabled></td>
            <%}%>
            <% if(pregunta.getOpcion()==5 ){%>
            <td><input class="check" type="radio"  disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio"  disabled></td>
            <%}%>
            <td colspan="2"><textarea name="c_o_1" cols="56" disabled> <%=(pregunta.getComentario()==null)?" " : pregunta.getComentario()%> </textarea></td>
            <td class="c_error" id="m_o_1"> </td>
        <tr> <td>10.- Considera que la iluminación, aislamiento de ruido y condiciones de seguridad fueron</td>
            <%pregunta = (Preguntas)iter.next();
            if(pregunta.getOpcion()==10 ){%>
            <td><input class="check" type="radio" disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio" disabled></td>
            <%}%>
            <% if(pregunta.getOpcion()==8 ){%>
            <td><input class="check" type="radio" disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio" disabled></td>
            <%}%>
            <% if(pregunta.getOpcion()==6 ){%>
            <td><input class="check" type="radio" disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio"  disabled></td>
            <%}%>
            <% if(pregunta.getOpcion()==5 ){%>
            <td><input class="check" type="radio"  disabled checked></td>
            <%}else{%>
            <td><input class="check" type="radio"  disabled></td>
            <%}%>
            <td colspan="2"><textarea name="c_o_1" cols="56" disabled> <%=(pregunta.getComentario()==null)?" " : pregunta.getComentario()%> </textarea></td>
            <td class="c_error" id="m_o_1"> </td>
            
            </table>

            <table width="827" >
            <tr> <td width="345">&nbsp;</td> <td class="centradoForm" width="84"></td>  <td class="centradoForm" width="84"></td> <td class="centradoForm" width="84"></td><td></td></tr>
            <tr> <td  colspan="5" class="sombreado">D.- ATENCIÓN A FALLAS</td>  </tr>
            <tr> <td   colspan="5" >11a. En caso de haberse presentado fallas, indica si fue oportuna su atención para cada uno de los siguientes equipos:</td></tr>

            <tr>
            <td></td>
            <td class="centradoForm" width="84">No hubo fallas</td>
            <td class="centradoForm" width="84">Si fue oportuna</td>
            <td class="centradoForm" width="84">No fue oportunaa</td>
            <td></td>
            </tr>

            <tr><td>A) Equipo de control (PCL)</td>
            
                <%pregunta = (Preguntas)iter.next();
                if(pregunta.getOpcion()==0 ){%>
                <td><input class="check" type="radio" disabled checked></td>
                <%}else{%>
                <td><input class="check" type="radio" disabled></td>
                <%}%>
                <% if(pregunta.getOpcion()==1 ){%>
                <td><input class="check" type="radio" disabled checked></td>
                <%}else{%>
                <td><input class="check" type="radio" disabled></td>
                <%}%>
                <% if(pregunta.getOpcion()==2 ){%>
                <td><input class="check" type="radio" disabled checked></td>
                <%}else{%>
                <td><input class="check" type="radio"  disabled></td>
                <%}%></tr>
                
           <tr> <td>B) Equipo neumático</td>

                <%pregunta = (Preguntas)iter.next();
                if(pregunta.getOpcion()==0 ){%>
                <td><input class="check" type="radio" disabled checked></td>
                <%}else{%>
                <td><input class="check" type="radio" disabled></td>
                <%}%>
                <% if(pregunta.getOpcion()==1 ){%>
                <td><input class="check" type="radio" disabled checked></td>
                <%}else{%>
                <td><input class="check" type="radio" disabled></td>
                <%}%>
                <% if(pregunta.getOpcion()==2 ){%>
                <td><input class="check" type="radio" disabled checked></td>
                <%}else{%>
                <td><input class="check" type="radio"  disabled></td>
                <%}%></tr>
                
                <tr> <td>C) Equipo de cómputo (Software)</td>
                <%pregunta = (Preguntas)iter.next();
                if(pregunta.getOpcion()==0 ){%>
                <td><input class="check" type="radio" disabled checked></td>
                <%}else{%>
                <td><input class="check" type="radio" disabled></td>
                <%}%>
                <% if(pregunta.getOpcion()==1 ){%>
                <td><input class="check" type="radio" disabled checked></td>
                <%}else{%>
                <td><input class="check" type="radio" disabled></td>
                <%}%>
                <% if(pregunta.getOpcion()==2 ){%>
                <td><input class="check" type="radio" disabled checked></td>
                <%}else{%>
                <td><input class="check" type="radio"  disabled></td>
                <%}%></tr>
                
                <tr> <td>D) Equipo de cómputo (Hardware)</td>
                <%pregunta = (Preguntas)iter.next();
                if(pregunta.getOpcion()==0 ){%>
                <td><input class="check" type="radio" disabled checked></td>
                <%}else{%>
                <td><input class="check" type="radio" disabled></td>
                <%}%>
                <% if(pregunta.getOpcion()==1 ){%>
                <td><input class="check" type="radio" disabled checked></td>
                <%}else{%>
                <td><input class="check" type="radio" disabled></td>
                <%}%>
                <% if(pregunta.getOpcion()==2 ){%>
                <td><input class="check" type="radio" disabled checked></td>
                <%}else{%>
                <td><input class="check" type="radio"  disabled></td>
                <%}%></tr>
                
            </table>
                
                
                
<table width="925" >
     <tr class="centradoForm">
                                            <td width="400"></td>
                                            <td width="30" class="centradoForm"></td> <td width="30" class="centradoForm"></td>  <td width="30" class="centradoForm"></td>    <td width="30" class="centradoForm"></td>
                                            <td  width="317" ></td>
                                            <td  width="112" class="centradoForm"></td>
                                        </tr>
<% 
pregunta = (Preguntas)iter.next();
if (pregunta.getnPregunta()==15 ){
%>
   

                                        <tr class="centradoForm"  id="dis" >
                                            <td></td>
                                            <td colspan="2" class="centradoForm">Error del alumno</td> <td colspan="2"  class="centradoForm">Otras</td>  
                                            <td  >Especifique</td>
                                            <td class="centradoForm"></td>
                                             <td></td>
                                        </tr>
                                        
                                        
                                        <tr id="dis1" >
                                            <td>11b.- Motivo que originó la falla</td>
                                            <% if(pregunta.getOpcion()==0 ){%>
                                               <td  colspan="2"><input class="check" type="radio" disabled checked></td>
                                                <%}else{%>
                                               <td  colspan="2"><input class="check" type="radio" disabled></td>
                                                <%}%>
                                                <% if(pregunta.getOpcion()==1 ){%>
                                                <td  colspan="2"><input class="check" type="radio" disabled checked></td>
                                                <%}else{%>
                                                <td  colspan="2"><input class="check" type="radio"  disabled></td>
                                                <%}%>
                                                <td ><textarea  id="c_o_15" name="c_o_15" cols="47" disabled><%=(pregunta.getComentario()==null)?" " : pregunta.getComentario()%> </textarea></td>
                                            <td class="c_error" id="m_o_15"> </td> 

                                        </tr>

    <%
      pregunta = (Preguntas)iter.next();
     }
     %>

     
    <tr> <td colspan="6" class="sombreado">E.- SATISFACCIÓN DE SERVICIO</td> </tr>
    <tr class="centradoForm">
    <td ></td>
    <td colspan="2" class="centradoForm"></td> <td colspan="2" class="centradoForm"></td>  
    <td class="centradoForm"></td>
    <td></td>
    </tr>
    
    
    <tr class="centradoForm">
    <td ></td>
    <td colspan="2" class="centradoForm">Sí</td> <td colspan="2" class="centradoForm">No</td>  
    <td class="centradoForm">¿Por qué?</td>
    <td   class="centradoForm"></td>
    <td></td>
    </tr>

        <tr>
        <td>12.- ¿Consideras que se cumplió el objetivo de la práctica?</td>
        
        <% 
        if(pregunta.getOpcion()==0 ){%>
        <td  colspan="2"><input class="check" type="radio" disabled checked></td>
        <%}else{%>
        <td  colspan="2"><input class="check" type="radio" disabled></td>
        <%}%>
        <% if(pregunta.getOpcion()==1 ){%>
        <td  colspan="2"><input class="check" type="radio" disabled checked></td>
        <%}else{%>
        <td  colspan="2"><input class="check" type="radio" disabled></td>
        <%}%>
        <td ><textarea  id="c_o_16" name="c_o_16" cols="47" disabled>  <%=(pregunta.getComentario()==null)?" " : pregunta.getComentario()%> </textarea></td>
        <td class="c_error" id="m_o_16"> </td> 

        </tr>


<tr  class="centradoForm"> <td></td>
<td  class="centradoForm">10</td> <td class="centradoForm">8</td> <td  class="centradoForm">6</td> <td class="centradoForm">5</td>
<td class="centradoForm">Especifique causas de insatisfacción</td>
<td></td>
</tr>

<tr>
<td>13.- Tu satisfacción respecto al servicio proporcionado por el laboratorio fue</td>
<% pregunta = (Preguntas)iter.next();

    if(pregunta.getOpcion()==10 ){%>
    <td><input class="check" type="radio" disabled checked></td>
    <%}else{%>
    <td><input class="check" type="radio" disabled></td>
    <%}%>
    <% if(pregunta.getOpcion()==8 ){%>
    <td><input class="check" type="radio" disabled checked></td>
    <%}else{%>
    <td><input class="check" type="radio" disabled></td>
    <%}%>
    <% if(pregunta.getOpcion()==6 ){%>
    <td><input class="check" type="radio" disabled checked></td>
    <%}else{%>
    <td><input class="check" type="radio"  disabled></td>
    <%}%>
    <% if(pregunta.getOpcion()==5 ){%>
    <td><input class="check" type="radio"  disabled checked></td>
    <%}else{%>
    <td><input class="check" type="radio"  disabled></td>
    <%}%>
    <td colspan="2"><textarea name="c_o_1" cols="56" disabled> <%=(pregunta.getComentario()==null)?" " : pregunta.getComentario()%> </textarea></td>
    <td class="c_error" id="m_o_1"> </td> 
    </tr>


<tr>
<td colspan="7">COMENTARIOS Y/O SUGERENCIAS:</td>
</tr>
<tr>
    <% if(iter.hasNext()) { 
        pregunta = (Preguntas)iter.next();
        %> <td colspan="7"><textarea id="c_o_18" name="c_o_18" cols="108" disabled > <%=(pregunta.getComentario()==null)?" " : pregunta.getComentario()%> </textarea></td>
    <%}else{ %><td colspan="7"><textarea id="c_o_18" name="c_o_18" cols="108" disabled>   </textarea></td> <%}%>
<td class="c_error" id="m_o_18"></td>

</tr>

<tr><td colspan="7">

<br> Nuestro compromiso es brindarte un servicio de calidad. GRACIAS POR TU COLABORACIÓN.</br>
</td></tr>
</table>

</form>


</body>
</html>