<%@page import="entity.Encuesta"%>
<%@ page session="true" %>
<%@page import="entity.Usuario"%>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

    
    <jsp:useBean id="cuesUs" scope="session" class="entity.Usuario" />
    <jsp:useBean id="encuesta" scope="page" class="entity.Encuesta" />
    <jsp:useBean id="abcEnc" scope="session" class="ABC.ABCEncuestas" />

<body>
    
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<jsp:useBean id="alumno" scope="page" class="ABC.ABCAlumnos" />
        <%alumno.getAlumno(cuesUs.getUser());
      
        
             encuesta.setIdAlumno(cuesUs.getUser());
            encuesta.setIdPractica(Integer.parseInt(request.getParameter("param")));
            abcEnc.gettPracticas(Integer.parseInt(request.getParameter("prac")),cuesUs.getUser());
            abcEnc.setEncuesta(encuesta);
         
        %>
<form name="form1" action="control/c1.jsp" method="post">
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
          <td width="292">Alumno: <%=alumno.alumno.getNombre()+" "%><%=alumno.alumno.getApeP()+" "%><%=alumno.alumno.getApeM()+" "%> </td>
          <td width="243">Grupo: <%=alumno.alumno.getGrupo() %> </td>
          <td width="341">Brigada: <%=alumno.alumno.getBrigada() %> </td>
        </tr>
        <tr>
             
          <td>Práctica: <%=abcEnc.practica.getNombre() %></td>
          <td>Fecha:<%java.util.Date fecha = new java.util.Date(); %><%=fecha.getDay() + " / " +  fecha.getMonth() + " / " +(fecha.getYear()+1900)%></td>
          <td> <%=abcEnc.practica.getSemestre()%></td>
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
    <td><input class="check" type="radio" name="o_1" value="10"></td>
    <td><input class="check" type="radio" name="o_1" value="8" ></td>
    <td><input class="check" type="radio" name="o_1" value="6"  ></td>
    <td><input class="check" type="radio" name="o_1" value="5" ></td>
    <td colspan="2"><textarea  id="c_o_1" name="c_o_1" cols="56"></textarea></td>
    <td class="c_error" id="m_o_1"> </td> 
  </tr>
  <tr>
    <td>2.- La disponibilidad del  equipo fue</td>
    <td><input type="radio" name="o_2" value="10"></td>
    <td><input type="radio" name="o_2" value="8"></td>
    <td><input type="radio" name="o_2" value="6"></td>
    <td><input type="radio" name="o_2" value="5"></td>
    <td colspan="2"><textarea  id="c_o_2" name="c_o_2" cols="56"></textarea></td>
      <td class="c_error" id="m_o_2"> </td>   
  </tr>
  <tr>
    <td>3.- La disponibilidad del  material fue</td>
    <td><input type="radio" name="o_3" value="10"></td>
    <td><input type="radio" name="o_3" value="8"></td>
    <td><input type="radio" name="o_3" value="6"></td>
    <td><input type="radio" name="o_3" value="5"></td>
    <td colspan="2"><textarea id="c_o_3" name="c_o_3" cols="56"></textarea></td>
      <td class="c_error" id="m_o_3"> </td> 
  </tr>
  <tr>
    <td>4a.- El funcionamiento del equipo de control (PLC) para realizar las prácticas fue</td>
    <td><input type="radio" name="o_4" value="10"></td>
    <td><input type="radio" name="o_4" value="8"></td>
    <td><input type="radio" name="o_4" value="6"></td>
    <td><input type="radio" name="o_4" value="5"></td>
    <td colspan="2"><textarea id="c_o_4" name="c_o_4" cols="56"></textarea></td>
    <td class="c_error" id="m_o_4"> </td> 
      <td></td>
  </tr>
    <tr>
    <td>4b.- El funcionamiento del equipo neumático para realizar las prácticas fue</td>
    <td><input type="radio" name="o_5" value="10"></td>
    <td><input type="radio" name="o_5" value="8"></td>
    <td><input type="radio" name="o_5" value="6"></td>
    <td><input type="radio" name="o_5" value="5"></td>
    <td colspan="2"><textarea id="c_o_5" name="c_o_5" cols="56"></textarea></td>
    <td class="c_error" id="m_o_5"> </td> 
      <td></td>
  </tr>
    
     <tr>
    <td>4c.- El funcionamiento del equipo de cómputo (Software)  para realizar las prácticas fue</td>
    <td><input type="radio" name="o_6" value="10"></td>
    <td><input type="radio" name="o_6" value="8"></td>
    <td><input type="radio" name="o_6" value="6"></td>
    <td><input type="radio" name="o_6" value="5"></td>
    <td colspan="2"><textarea id="c_o_6" name="c_o_6" cols="56"></textarea></td>
    <td class="c_error" id="m_o_6"> </td> 
      <td></td>
  </tr>
    
     <tr>
    <td>4d.- El funcionamiento del equipo de cómputo (Hardware)  para realizar las prácticas fue</td>
    <td><input type="radio" name="o_7" value="10"></td>
    <td><input type="radio" name="o_7" value="8"></td>
    <td><input type="radio" name="o_7" value="6"></td>
    <td><input type="radio" name="o_7" value="5"></td>
    <td colspan="2"><textarea id="c_o_7" name="c_o_7" cols="56"></textarea></td>
    <td class="c_error" id="m_o_7"> </td> 
      <td></td>
  </tr>
    
     <tr>
    <td>5.- La disponibilidad del manual de prácticas fue</td>
    <td><input type="radio" name="o_8" value="10"></td>
    <td><input type="radio" name="o_8" value="8"></td>
    <td><input type="radio" name="o_8" value="6"></td>
    <td><input type="radio" name="o_8" value="5"></td>
    <td colspan="2"><textarea id="c_o_8" name="c_o_8" cols="56"></textarea></td>
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
    <td><input type="radio" name="o_9" value="10"></td>
    <td><input type="radio" name="o_9" value="8"></td>
    <td><input type="radio" name="o_9" value="6"></td>
    <td><input type="radio" name="o_9" value="5"></td>
    <td colspan="2"><textarea id="c_o_9" name="c_o_9" cols="56"></textarea></td>
     <td class="c_error" id="m_o_9"> </td> 
  </tr>
  <tr>
    <td>7.- La funcionalidad de las instalaciones (eléctricas, neumática y de iluminación) fue: </td>
    <td><input type="radio" name="o_10" value="10"></td>
    <td><input type="radio" name="o_10" value="8"></td>
    <td><input type="radio" name="o_10" value="6"></td>
    <td><input type="radio" name="o_10" value="5"></td>
    <td colspan="2"><textarea id="c_o_10" name="c_o_10" cols="56"></textarea></td>
    <td class="c_error" id="m_o_10"> </td> 
  </tr>
  <tr>
      <td>8.- Consideras que la ventilaci&oacute;n, aislamiento de ruido y condiciones de seguridad fueron: </td>
    <td><input type="radio" name="o_11" value="10"></td>
    <td><input type="radio" name="o_11" value="8"></td>
    <td><input type="radio" name="o_11" value="6"></td>
    <td><input type="radio" name="o_11" value="5"></td>
    <td colspan="2"><textarea id="c_o_11" name="c_o_11" cols="56"></textarea></td>
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
    <td><input type="radio" name="o_12" value="10"></td>
    <td><input type="radio" name="o_12" value="8"></td>
    <td><input type="radio" name="o_12" value="6"></td>
    <td><input type="radio" name="o_12" value="5"></td>
    <td colspan="2"><textarea id="c_o_12" name="c_o_12" cols="56"></textarea></td>
    <td class="c_error" id="m_o_12"> </td> 
  </tr>
     <tr>
    <td>10.- Tu satisfacci&oacute;n general con respecto al servicio proporcionado por el laboratorio fue:</td>
    <td><input type="radio" name="o_13" value="10"></td>
    <td><input type="radio" name="o_13" value="8"></td>
    <td><input type="radio" name="o_13" value="6"></td>
    <td><input type="radio" name="o_13" value="5"></td>
    <td colspan="2"><textarea id="c_o_13" name="c_o_13" cols="56"></textarea></td>
    <td class="c_error" id="m_o_13"> </td> 
  </tr>
  
  <tr>
    <td colspan="7">COMENTARIOS Y/O SUGERENCIAS:</td>
  </tr>
  <tr>
    <td colspan="7"><textarea id="c_o_14"  name="c_o_14" cols="108"></textarea></td>
      <td class="c_error" id="m_o_14"></td>
  </tr>
  <tr>
    <td colspan="7" class="Negrita"><p>Si deseas que se te informe del seguimiento que se ha dado a tu sugerencias, favor de proporcionar tu correo electrÃ³nico: </p></td>
  </tr>
  <tr>
    <td colspan="7" class="Negrita">Nuestro compromiso es brindarte un servicio de calidad. GRACIAS POR TU COLABORACIÓN</td>
  </tr>
</table>

          <center> <input type="button" value="Enviar"  onclick="enviarForm(this.form,'s');"/> </center>
<!--p id="boton"> 
    <input type="button"  class="boton" onclick="/*sendForm(this.form,'control/c1.jsp','principal');*/checar();"/></p

-->
</form>
       


         
       
</body>
</html>