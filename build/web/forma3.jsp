<%@page import="entity.Encuesta"%>
<%@ page session="true" %>
<%@page import="entity.Usuario"%>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <jsp:useBean id="cuesUs" scope="session" class="entity.Usuario" />
    <jsp:useBean id="encuesta" scope="page" class="entity.Encuesta" />
    <jsp:useBean id="abcEnc" scope="session" class="ABC.ABCPracticas" />

    <body>


        <jsp:useBean id="alumno" scope="page" class="ABC.ABCAlumnos" />
        <%alumno.getAlumno(cuesUs.getUser());

            encuesta.setIdAlumno(cuesUs.getUser());
            //encuesta.setIdPractica(Integer.parseInt(request.getParameter("param")));
            //abcEnc.gettPracticas(Integer.parseInt(request.getParameter("prac")));
            //abcEnc.setEncuesta(encuesta);

        %>
        <form name="form3" id="form3" action="control/c1.jsp" method="post">
            <table width="925" height="217">
                <tr>
                    <td width="161" height="109"><center><img src="http://www.ingenieria.unam.mx/imagenes/escudo_fi_color_dibujo_354x425_trans.gif" alt="" name="irc_mi" width="115" height="137" align="top" id="irc_mi" /></center></td>
                    <td width="429" class="centrado" style="text-align: center; font-size: larger; font-weight: bold;">Formato de quejas, sugerencias y felicitaciones</td>
                    <td width="313" height="109" style="text-align:right"> <table width="313" >
                            <tr>
                                <td width="150">Código</td>
                                <td  class="centradoForm">FODO-16</td>
                            </tr>
                            <tr>
                                <td>Versión </td>
                                <td  class="centradoForm">01</td>
                            </tr>
                            <tr>
                                <td height="32">Página</td>
                                <td  class="centradoForm" >1/1</td>
                            </tr>
                            <tr class="sombreado">
                                <td>Sección ISO</td>
                                <td  class="centradoForm" >7.2.3</td>
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
<,`             <tr>   
                    <td>Semestre:</td>
                    <td>Fecha:<%=new java.util.Date()%> </td>
                    
                    
                    
                        <p>&nbsp;</p></td>
                </tr>
            </table>

            <table >

                <tr class="centradoForm">
                  

                    <tr> <td width="40"></td>  <td width="100"></td></tr>
                                           
                                    <tr>
                                        <td colspan="2">Por favor, incluya la informaci&oacute;n que considere relevante para atender su queja o sugerencia o felicitaci&oacute;n:</td>
                                     </tr>
                                     <tr colspan="2">
                                           <td><textarea id="comen"   name="comen" cols="47"></textarea>  </td>
                                     </tr>       
                                       </table >
                                         <table>
                                     <tr>
                                         <td> Deseo que obtener informe del seguimiento de mi sugerencia: </td><td> <input type="checkbox" id="seguir" name="seguir" value="1"> <td/></tr>
                                             <tr> <td colspan="2">  <input type="button" onclick="sendBuzon(this.form);" value="Enviar">  </input> </td></tr>
                    
                                            </table>
                                        <!--tr colspan="2">
                                        <td>Si desea que se le informe del seguimiento que se ha dado a su sugerencia, favor de proporsionar los sigueintes datos
                                        </td>
                                        </tr>
                                        </table>
                                        
                    
                                        <table>         
                                        <tr>
                                         <td>Nombre:</td> <td><input type="text"/></td>
                                        </tr>
                                        <tr>
                                         <td>Correo electr&oacute;nico:</td> <td><input type="text"/></td>
                                     </tr>
                                         </table-->
                                   
                                    </form>

                                    </body>
                                    </html>