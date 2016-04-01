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
                                <td width="292">Alumno: <%=alumno.alumno.getNombre() + " "%><%=alumno.alumno.getApeP() + " "%><%=alumno.alumno.getApeM() + " "%> </td>
                                <td width="243">Grupo: <%=alumno.alumno.getGrupo()%> </td>
                                <td width="341">Brigada: <%=alumno.alumno.getBrigada()%> </td>
                            </tr>
                            <tr>

                                <td>Práctica: <%=abcEnc.practica.getNombre()%></td>
                                <td>Fecha:<%java.util.Date fecha = new java.util.Date(); %><%=fecha.getDay() + " / " +  fecha.getMonth() + " / " +(fecha.getYear()+1900)%>
                                        </td>
                                <td>Semestre: <%=abcEnc.practica.getSemestre()%></td>
                            </tr>
                        </table>
                        <p>&nbsp;</p></td>
                </tr>
            </table>

            <table width="925" >

                <tr class="centradoForm">
                    <td width="400"><p>Responde según la siguiente escala: <br>&nbsp;10: Muy buena&nbsp; &nbsp;&nbsp; 8:Buena  <br>&nbsp;&nbsp;6: Regular &nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; 5:Mala</p></td>
                                    <td width="30" class="centradoForm"></td> <td width="30" class="centradoForm"></td>  <td width="30" class="centradoForm"></td>    <td width="30" class="centradoForm"></td>
                                    <td  width="317" >En caso de que no haya sido de tu completa satisfacción, requerimos nos ayudes a identificar los aspectos a mejorar en cada rubro, utilizando los siguientes espacios.</td>
                                    <td  width="112" class="centradoForm"></td>
                                    </tr>

                                    <tr> <td colspan="6" class="sombreado">A.- DESARROLLO DE LA PRACTICA</td> </tr>
                                    <tr> <td></td>
                                        <td  class="centradoForm">10</td> <td class="centradoForm">8</td> <td  class="centradoForm">6</td> <td class="centradoForm">5</td>
                                        <td></td>
                                        <td></td>
                                    </tr>

                                    <tr>
                                        <td>1.- ¿Se te entregó el material necesario y suficiente para la realización de la práctica?</td>
                                        <td><input class="check" type="radio" name="o_1" value="10"></td>
                                        <td><input class="check" type="radio" name="o_1" value="8" ></td>
                                        <td><input class="check" type="radio" name="o_1" value="6"  ></td>
                                        <td><input class="check" type="radio" name="o_1" value="5" ></td>
                                        <td ><textarea  id="c_o_1" name="c_o_1" cols="47"></textarea></td>
                                        <td class="c_error" id="m_o_1"> </td> 
                                    </tr>

                                    <tr>
                                        <td>2.- La disponibilidad del material y equipo para realizar la práctica fue</td>
                                        <td><input type="radio" name="o_2" value="10"></td>
                                        <td><input type="radio" name="o_2" value="8"></td>
                                        <td><input type="radio" name="o_2" value="6"></td>
                                        <td><input type="radio" name="o_2" value="5"></td>
                                        <td ><textarea  id="c_o_2" name="c_o_2" cols="47"></textarea></td>
                                        <td class="c_error" id="m_o_2"> </td>   
                                    </tr>

                                    <tr>
                                        <td>3.- ¿El profesor dio a conocer el objetivo al inicio de la práctica?</td>
                                        <td><input type="radio" name="o_3" value="10"></td>
                                        <td><input type="radio" name="o_3" value="8"></td>
                                        <td><input type="radio" name="o_3" value="6"></td>
                                        <td><input type="radio" name="o_3" value="5"></td>
                                        <td ><textarea id="c_o_3" name="c_o_3" cols="47"></textarea></td>
                                        <td class="c_error" id="m_o_3"> </td> 
                                    </tr>

                                    <tr>
                                        <td>4.- El funcionamiento del equipo para realizar la práctica fue</td>
                                        <td><input type="radio" name="o_4" value="10"></td>
                                        <td><input type="radio" name="o_4" value="8"></td>
                                        <td><input type="radio" name="o_4" value="6"></td>
                                        <td><input type="radio" name="o_4" value="5"></td>
                                        <td ><textarea id="c_o_4" name="c_o_4" cols="47"></textarea></td>
                                        <td class="c_error" id="m_o_4"> </td> 
                                    </tr>



                                    <tr> <td colspan="6" class="sombreado">B.- PROFESOR</td> </tr>

                                    <tr>
                                        <td></td>
                                        <td  class="centradoForm">10</td> <td class="centradoForm">8</td> <td  class="centradoForm">6</td> <td class="centradoForm">5</td>
                                        <td></td>
                                        <td></td>
                                    </tr>

                                    <tr>
                                        <td>5.- La explicación de los conceptos previos a la páctica fue</td>
                                        <td><input type="radio" name="o_5" value="10"></td>
                                        <td><input type="radio" name="o_5" value="8"></td>
                                        <td><input type="radio" name="o_5" value="6"></td>
                                        <td><input type="radio" name="o_5" value="5"></td>
                                        <td ><textarea id="c_o_5" name="c_o_5" cols="47"></textarea></td>
                                        <td class="c_error" id="m_o_5"> </td> 
                                    </tr>


                                    <tr>
                                        <td>6.- Las indicaciones para el desarrollo de la práctica fueron</td>
                                        <td><input type="radio" name="o_6" value="10"></td>
                                        <td><input type="radio" name="o_6" value="8"></td>
                                        <td><input type="radio" name="o_6" value="6"></td>
                                        <td><input type="radio" name="o_6" value="5"></td>
                                        <td ><textarea id="c_o_6" name="c_o_6" cols="47"></textarea></td>
                                        <td class="c_error" id="m_o_6"> </td> 
                                    </tr>

                                    <tr>
                                        <td>7.- La aclaracion de dudas durante la práctica fue</td>
                                        <td><input type="radio" name="o_7" value="10"></td>
                                        <td><input type="radio" name="o_7" value="8"></td>
                                        <td><input type="radio" name="o_7" value="6"></td>
                                        <td><input type="radio" name="o_7" value="5"></td>
                                        <td ><textarea id="c_o_7" name="c_o_7" cols="47"></textarea></td>
                                        <td class="c_error" id="m_o_7"> </td> 
                                    </tr>


                                    <tr><td colspan="6" class="sombreado">C.- INSTALACIONES</td>  </tr>

                                    <tr>
                                        <td></td>
                                        <td  class="centradoForm">10</td> <td class="centradoForm">8</td> <td  class="centradoForm">6</td> <td class="centradoForm">5</td>
                                        <td></td>
                                        <td></td>
                                    </tr>

                                    <tr>
                                        <td><p>8.- ¿Se cuenta con las mesas y sillas adecuadas para la realización de  la práctica?</p></td>
                                        <td><input type="radio" name="o_8" value="10"></td>
                                        <td><input type="radio" name="o_8" value="8"></td>
                                        <td><input type="radio" name="o_8" value="6"></td>
                                        <td><input type="radio" name="o_8" value="5"></td>
                                        <td ><textarea id="c_o_8" name="c_o_8" cols="47"></textarea></td>
                                        <td class="c_error" id="m_o_8"> </td> 
                                    </tr>

                                    <tr>
                                        <td>9.- La funcionalidad de las instalaciones (eléctricas, neumática y de iluminación) fue </td>
                                        <td><input type="radio" name="o_9" value="10"></td>
                                        <td><input type="radio" name="o_9" value="8"></td>
                                        <td><input type="radio" name="o_9" value="6"></td>
                                        <td><input type="radio" name="o_9" value="5"></td>
                                        <td ><textarea id="c_o_9" name="c_o_9" cols="47"></textarea></td>
                                        <td class="c_error" id="m_o_9"> </td> 
                                    </tr>

                                    <tr>
                                        <td>10.- Considera que la iluminación, aislamiento de ruido y condiciones de seguridad fueron</td>
                                        <td><input type="radio" name="o_10" value="10"></td>
                                        <td><input type="radio" name="o_10" value="8"></td>
                                        <td><input type="radio" name="o_10" value="6"></td>
                                        <td><input type="radio" name="o_10" value="5"></td>
                                        <td ><textarea id="c_o_10" name="c_o_10" cols="47"></textarea></td>
                                        <td class="c_error" id="m_o_10"> </td> 
                                    </tr>


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

                                        <tr>
                                            <td>A) Equipo de control (PLC)</td>
                                            <td class="centradoForm"><input type="radio" name="o_11" value="0"></td>
                                            <td class="centradoForm"><input type="radio" name="o_11" value="1"></td>
                                            <td  class="centradoForm"><input type="radio" name="o_11" value="2"></td>
                                            <td class="c_error" id="m_o_11"> </td> 
                                        </tr>

                                        <tr>
                                            <td>B) Equipo neumático</td>
                                            <td class="centradoForm"><input type="radio" name="o_12" value="0"></td>
                                            <td class="centradoForm"> <input type="radio" name="o_12" value="1"></td>
                                            <td  class="centradoForm"><input type="radio" name="o_12" value="2"></td>
                                            <td class="c_error" id="m_o_12"> </td> 
                                        </tr>

                                        <tr>
                                            <td>C) Equipo de cómputo (Software)</td>
                                            <td class="centradoForm"><input type="radio" name="o_13" value="0"></td>
                                            <td class="centradoForm"><input type="radio" name="o_13" value="1"></td>
                                            <td  class="centradoForm"><input type="radio" name="o_13" value="2"></td>
                                            <td class="c_error" id="m_o_13"> </td> 
                                        </tr>

                                        <tr>
                                            <td>C) Equipo de cómputo (Hardware)</td>
                                            <td class="centradoForm"><input type="radio" name="o_14" value="0"></td>
                                            <td class="centradoForm"><input type="radio" name="o_14" value="1"></td>
                                            <td  class="centradoForm"><input type="radio" name="o_14" value="2"></td>
                                            <td class="c_error" id="m_o_14"> </td> 
                                        </tr>
                                    </table>

                                 <table width="925" >

                                        <tr class="centradoForm">
                                            <td width="400"></td>
                                            <td width="30" class="centradoForm"></td> <td width="30" class="centradoForm"></td>  <td width="30" class="centradoForm"></td>    <td width="30" class="centradoForm"></td>
                                            <td  width="317" ></td>
                                            <td  width="112" class="centradoForm"></td>
                                        </tr>

                                        <tr class="centradoForm"  id="dis" style="display: none;">
                                            <td></td>
                                            <td colspan="2" class="centradoForm">Error del alumno</td> <td colspan="2"  class="centradoForm">Otras</td>  
                                            <td  >Especifique</td>
                                            <td class="centradoForm"></td>
                                             <td></td>
                                        </tr>
                                        
                                        
                                        <tr id="dis1" style="display: none;">
                                            <td>11b.- Motivo que originó la falla</td>
                                            <td  colspan="2"><input class="check" type="radio" name="o_15" value="0"  ></td>
                                            <td  colspan="2"><input class="check" type="radio" name="o_15" value="1" ></td>
                                            <td ><textarea  id="c_o_15" name="c_o_15" cols="47"></textarea></td>
                                            <td class="c_error" id="m_o_15"> </td> 

                                        </tr>


                                        <tr> <td colspan="6" class="sombreado">E.- SATISFACCIÓN DE SERVICIO</td> </tr>

                                        <tr class="centradoForm">
                                            <td ></td>
                                            <td colspan="2" class="centradoForm">Sí</td> <td colspan="2" class="centradoForm">No</td>  
                                            <td class="centradoForm">¿Por qué?</td>
                                            <td   class="centradoForm"></td>
                                             <td></td>
                                        </tr>

                                        <tr>
                                            <td>12.- ¿Consideras que se cumplió el objetivo de la práctica?</td>
                                            <td  colspan="2"><input class="check" type="radio" name="o_16" value="0"  ></td>
                                            <td  colspan="2"><input class="check" type="radio" name="o_16" value="1" ></td>
                                            <td ><textarea  id="c_o_16" name="c_o_16" cols="47"></textarea></td>
                                             <td class="c_error" id="m_o_16"> </td> 

                                        </tr>


                                        <tr  class="centradoForm"> <td></td>
                                            <td  class="centradoForm">10</td> <td class="centradoForm">8</td> <td  class="centradoForm">6</td> <td class="centradoForm">5</td>
                                            <td class="centradoForm">Especifique causas de insatisfacción</td>
                                            <td></td>
                                        </tr>

                                        <tr>
                                            <td>13.- Tu satisfacción respecto al servicio proporcionado por el laboratorio fue</td>
                                            <td><input class="check" type="radio" name="o_17" value="10"></td>
                                            <td><input class="check" type="radio" name="o_17" value="8" ></td>
                                            <td><input class="check" type="radio" name="o_17" value="6"  ></td>
                                            <td><input class="check" type="radio" name="o_17" value="5" ></td>
                                            <td ><textarea  id="c_o_17" name="c_o_17" cols="47"></textarea></td>
                                            <td class="c_error" id="m_o_17"> </td> 
                                        </tr>


                                        <tr>
                                            <td colspan="7">COMENTARIOS Y/O SUGERENCIAS:</td>
                                        </tr>
                                        <tr>
                                            <td colspan="7"><textarea id="c_o_18" name="c_o_18" cols="108"></textarea></td>
                                            <td class="c_error" id="m_o_18"></td>
                                            
                                        </tr>
                                        
                                        <tr><td colspan="7">
                                                 <center> <input type="button" value="Enviar"  onclick="enviarForm(this.form, 'p');"/> </center>
                                                 <br> Nuestro compromiso es brindarte un servicio de calidad. GRACIAS POR TU COLABORACIÓN.</br>
                                            </td></tr>
                                    </table>
                                   
                                    </form>

                                    </body>
                                    </html>