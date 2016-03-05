<jsp:useBean id="buzon" scope="page" class="ABC.ABCBuzon" />

<jsp:useBean id="semestre" scope="session" class="ABC.ABCSemestre" />
<img width="20" style=" top: -16px; " id="btn_salir" src="imgs/cross.png" onclick="$('#showComment').hide();">

   <%
   int x = Integer.parseInt(request.getParameter("param"));
   %>
   
   
      
     <jsp:useBean id="cuesUs" scope="session" class="entity.Usuario" />
    <jsp:useBean id="alumno" scope="page" class="ABC.ABCAlumnos" />
  
    <%
   buzon.viewQueja(semestre.getCurrent(),x);
   alumno.getAlumno(buzon.getBuzon().getAlumno());

        %>

        
         <form name="form1" action="control/c1.jsp" method="post">
            <table width="925" >
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
                        </table>
                        
                         </tr>
                <tr>
                    <td height="23" colspan="3" style="text-align: center; font-size: larger; font-weight: bold;">Secretaria/División: División de Ingeniería Mecánica e Industrial  Área/Departamento: Laboratorio de automatización Industrial </td>
                </tr>
                <tr>
            </table>
            
             <table width="925" >
                 
                 <tr><td>Semestre:</td>    <td> <%=alumno.alumno.getSemestre() %></td><td>Fecha:</td>    <td> <%=buzon.getBuzon().getFecha() %></td></tr>
                 <tr><td colspan="2">Por favor, incluya toda la información que considere relevante para atender su queja o sugerencia o felicitación:</td>  </tr>
                 
             
             </table>
                 
                 <div id="comentarioBuzon">
                     
                     
                  <div style="padding-bottom: 5px;">
                     <p> 
                      Mensaje:
                      </p>
                     <%=buzon.getBuzon().getQueja()%>
                 
                  </div>
                    
                 <div>
                      <p>Respuesta:</p>
                      
                     <%
                         if(buzon.getBuzon().getRespesta() == null){
                       %>      <textarea id="answearBuzon" name="comentarios">Escribe aquí tus comentarios</textarea>
                             <input onclick="answerBuzon(<%=buzon.getBuzon().getId()%>)" type="button" value="Enviar" style="right: 5px; position:relative; left: 528px;">
                    
                         
                       <%}else{%> 
                       
                       <textarea id="answearBuzon" name="comentarios" disabled>  <%= buzon.getBuzon().getRespesta() %> </textarea>
                       
                       <% } %>
                 </div>
                 </div>