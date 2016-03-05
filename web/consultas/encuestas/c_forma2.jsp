<%@page import="entity.Preguntas"%>
<%@page import="java.util.Iterator"%>
<%@page import="entity.Encuesta"%>
<%@ page session="true" %>
<%@page import="entity.Usuario"%>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<jsp:useBean id="cuesUs" scope="session" class="entity.Usuario" />

<jsp:useBean id="practica" scope="session" class="ABC.ABCEncuestas" />
<jsp:useBean id="pregunta" scope="session" class="entity.Preguntas" />

<jsp:useBean id="alumno" scope="page" class="ABC.ABCAlumnos" />
        <%
            practica.getInfo(Integer.parseInt(request.getParameter("param")));
            Iterator iter = practica.encuesta.getL().iterator();
        %>

<img id="btn_salir" src="imgs/cross.png" onclick="$('#showEncuesta').hide();">
    
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

        
<table width="925" height="217">
  <tr>
    <td width="161" height="109"><center><img src="http://www.ingenieria.unam.mx/imagenes/escudo_fi_color_dibujo_354x425_trans.gif" alt="" name="irc_mi" width="115" height="137" align="top" id="irc_mi" /></center></td>
    <td width="429" class="centrado" style="text-align: center; font-size: larger; font-weight: bold;">Encuesta de evaluación del servicio</td>
    <td width="313" height="109" style="text-align:right"> <table width="313" >
     <tr>
            <td width="150">Código</td>
            <td width="170" class="centradoForm">FODO-07</td>
            </tr>
            <tr>
            <td>Versión </td>
            <td class="centradoForm">1</td>
            </tr>
            <tr>
            <td height="32">Página</td>
            <td  class="centradoForm">41275</td>
            </tr>
            <tr>
            <td class="sombreado">Sección ISO</td>
            <td class="sombreado"><center>5.2.5.5.3.</br>7.2.3.7.2.3.7.5.1.8.2.1</center></td>
            </tr>
            <tr>
            <td>Fecha de emisión </td>
            <td class="centradoForm">02 de agosto de 2013</td>
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
          <td width="243">Grupo: <%=practica.practica.getGrupo()%> </td>
          <td width="341">Brigada: <%=practica.practica.getBrigada() %> </td>
        </tr>
        <tr>
             
          <td>Práctica: <%= practica.practica.getNombre() %></td>
          <td>Fecha:<%=practica.practica.getFecha()%></td>
          <td>Semestre: <%=practica.practica.getSemestre()%></td>
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
  <tr>
    <td colspan="7" class="sombreado">A.- DESARROLLO DE LAS PRACTICAS</td>
  </tr>
    <tr>
    <td> </td>
    <td width="22" class="centradoForm">10</td>
    <td width="22" class="centradoForm">8</td>
    <td width="22" class="centradoForm">6</td>
    <td width="22" class="centradoForm">5</td>
    <td></td>
    </tr>
  <tr>
    <td>1.- ¿Se te entregó el material necesario y suficiente para la realización de las prácticas? </td>
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
    <td>2.- La disponibilidad del  equipo fue</td>
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
           
      <td class="c_error" id="m_o_2"> </td>   
  </tr>
  <tr>
    <td>3.- La disponibilidad del  material fue</td>
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
           
      <td class="c_error" id="m_o_3"> </td> 
  </tr>
  <tr>
    <td>4a.- El funcionamiento del equipo de control (PLC) para realizar las prácticas fue</td>
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
           
    <td class="c_error" id="m_o_4"> </td> 
      <td></td>
  </tr>
    <tr>
    <td>4b.- El funcionamiento del equipo neumático para realizar las prácticas fue</td>
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
           
    <td class="c_error" id="m_o_5"> </td> 
      <td></td>
  </tr>
    
     <tr>
    <td>4c.- El funcionamiento del equipo de cómputo (Software)  para realizar las prácticas fue</td>
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
           
    <td class="c_error" id="m_o_6"> </td> 
      <td></td>
  </tr>
    
     <tr>
    <td>4d.- El funcionamiento del equipo de cómputo (Hardware)  para realizar las prácticas fue</td>
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
           
    <td class="c_error" id="m_o_7"> </td> 
      <td></td>
  </tr>
    
     <tr>
    <td>5.- La disponibilidad del manual de prácticas fue</td>
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
           
    <td class="c_error" id="m_o_8"> </td> 
      <td></td>
  </tr>
    
   
  <tr>
    <td colspan="7" class="sombreado">B.- INSTALACIONES</td>
  </tr>
    <tr>
    <td></td>
    <td width="22" class="centradoForm">10</td>
    <td width="22" class="centradoForm">8</td>
    <td width="22" class="centradoForm">6</td>
    <td width="22" class="centradoForm">5</td>
    
    </tr>
  <tr>
    <td>6.- ¿Se cuenta con las mesas y sillas adecuadas para la realización de las prácticas?</td>
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
           
     <td class="c_error" id="m_o_9"> </td> 
  </tr>
  <tr>
    <td>7.- La funcionalidad de las instalaciones (eléctricas, neumática y de iluminación) fue: </td>
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
           
    <td class="c_error" id="m_o_10"> </td> 
  </tr>
  <tr>
      <td>8.- Consideras que la ventilaci&oacute;n, aislamiento de ruido y condiciones de seguridad fueron: </td>
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
           
       <td class="c_error" id="m_o_11"> </td> 
      <td></td>
  </tr>
   <tr>
  
    
    <td colspan="7" class="sombreado">C.- SATISFACCIÓN DE SERVICIO</td>
  </tr>
 <tr>
    <td> </td>
    <td width="22" class="centradoForm">10</td>
    <td width="22" class="centradoForm">8</td>
    <td width="22" class="centradoForm">6</td>
    <td width="22" class="centradoForm">5</td>
    <td></td>
    </tr>

            
   
    <tr>
    <td>9.- ¿El laboratorio cumplió con tus expectativas iniciales en cuanto a los conocimientos y habilidades adquiridas?</td>
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
           
    <td class="c_error" id="m_o_12"> </td> 
  </tr>
     <tr>
    <td>10.- Tu satisfacci&oacute;n general con respecto al servicio proporcionado por el laboratorio fue:</td>
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
           
    <td class="c_error" id="m_o_13"> </td> 
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
  <tr>
    <td colspan="7" class="Negrita"><p>Si deseas que se te informe del seguimiento que se ha dado a tu sugerencias, favor de proporcionar tu correo electrÃ³nico: </p></td>
  </tr>
  <tr>
    <td colspan="7" class="Negrita">Nuestro compromiso es brindarte un servicio de calidad. GRACIAS POR TU COLABORACIÓN</td>
  </tr>
</table>

       
</body>
</html>