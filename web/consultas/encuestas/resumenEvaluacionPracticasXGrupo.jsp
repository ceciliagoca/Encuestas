<%-- 
    Document   : general
    Created on : Nov 6, 2015, 4:00:59 PM
    Author     : cecilia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<jsp:useBean id="semestre" scope="session" class="ABC.ABCSemestre" />
<jsp:useBean id="cuesUs" scope="session" class="entity.Usuario" />
<jsp:useBean id="indicadores" scope="session" class="ABC.Indicadores" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
   
    <body>

        <% indicadores.setSemestre(semestre.getCurrent()); 
           int grupo = Integer.parseInt(request.getParameter("param"));
        %>
        
        <%="grupo " + grupo %>
        
        
        
        
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
                                <td> </td>
                                <td  class="centradoForm" >  <%=semestre.getCurrent() %>  </td>
                            </tr>
                        </table></td>
                </tr>
                <tr>
                    
                    
                      <td height="23" colspan="3" style="text-align: center; font-size: larger; font-weight: bold;">Secretaria/División: División de Ingeniería Mecánica e Industrial  Área/Departamento: Laboratorio de automatización Industrial </td>
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
                                    <tr> <td>Pregunta</td>
                                        <td> Calificación</td>
                                    </tr>

                                    <tr>
                                        <td>1.- ¿Se te entregó el material necesario y suficiente para la realización de la práctica?</td>
                                        <td>  <%= indicadores.promedioPracticas(1,grupo) %> </td> 
                                    </tr>
                                    <tr>
                                        <td>2.- La disponibilidad del material y equipo para realizar la práctica fue</td>
                                         <td>  <%= indicadores.promedioPracticas(2,grupo) %> </td>  
                                    </tr>

                                    <tr>
                                        <td>3.- ¿El profesor dio a conocer el objetivo al inicio de la práctica?</td>
                                       <td>  <%= indicadores.promedioPracticas(3,grupo) %> </td>  
                                    </tr>

                                         <tr>
                                        <td>4.- El funcionamiento del equipo para realizar la práctica fue</td>
                                        <td>  <%= indicadores.promedioPracticas(4,grupo) %> </td>  
                                    </tr>



                                    <tr> <td colspan="6" class="sombreado">B.- PROFESOR</td> </tr>

                                    <tr>
                                        <td>5.- La explicación de los conceptos previos a la páctica fue</td>
                                           <td>  <%= indicadores.promedioPracticas(5,grupo) %> </td>  
                                    </tr>


                                    <tr>
                                        <td>6.- Las indicaciones para el desarrollo de la práctica fueron</td>
                                           <td>  <%= indicadores.promedioPracticas(6,grupo) %> </td>  
                                    </tr>

                                    <tr>
                                        <td>7.- La aclaracion de dudas durante la práctica fue</td>
                                          <td>  <%= indicadores.promedioPracticas(7,grupo) %> </td>  
                                    </tr>


                                    <tr><td colspan="6" class="sombreado">C.- INSTALACIONES</td>  </tr>

                                      <tr>
                                        <td><p>8.- ¿Se cuenta con las mesas y sillas adecuadas para la realización de  la práctica?</p></td>
                                  <td>  <%= indicadores.promedioPracticas(8,grupo) %> </td>  
                                    </tr>

                                    <tr>
                                        <td>9.- La funcionalidad de las instalaciones (eléctricas, neumática y de iluminación) fue </td>
                                       <td>  <%= indicadores.promedioPracticas(9,grupo) %> </td>  
                                    </tr>

                                    <tr>
                                        <td>10.- Considera que la iluminación, aislamiento de ruido y condiciones de seguridad fueron</td>
                                       <td>  <%= indicadores.promedioPracticas(10,grupo) %> </td>  
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
                                         
                                            <td   class="centradoForm"></td>
                                             <td></td>
                                        </tr>

                                        <tr>
                                            <td>12.- ¿Consideras que se cumplió el objetivo de la práctica?</td>
                                            <td  colspan="2"> 100 </td>
                                            <td  colspan="2">0</td>
                                          

                                        </tr>


                                     

                                        <tr>
                                            <td>13.- Tu satisfacción respecto al servicio proporcionado por el laboratorio fue</td>
                                            <td>  <%= indicadores.promedioPracticas(13,grupo) %> </td>  
                                        </tr>

                                 </table>
                                    </body>
                                    </html>