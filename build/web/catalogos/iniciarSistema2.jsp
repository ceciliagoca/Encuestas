<%-- 
    Document   : iniciarSistema2
    Created on : Aug 14, 2014, 7:53:08 AM
    Author     : DIMEI
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%@page import="utils.Conexion"%>


<%
Conexion c = new Conexion();
       Connection  con = c.getConexion();
       PreparedStatement pstmt;
       ResultSet rs;
%>




<div id="i_3" class="inicioS" > 
     <div class="tituli"> Grupos </div> 
          
     <table id="tb_grupos">
          
         <tr><td>Clave de grupo</td><td>Profesor</td><td>Horario</td></tr>
          
         <% for(int i=0; i<4; i++ ){ %>
         <tr><td><select id="grupo_<%=i%>"> <option>1</option> <option>2</option> <option>3</option> <option>4</option></select></td>
              <td><input name="profesor" type="hidden" > <select id="profesor_<%=i%>">
          <%
                pstmt = con.prepareStatement("select * from l_profesores");
                rs = pstmt.executeQuery();
                while(rs.next()){
              
                %>
                
                <option value="<%=rs.getString(6)%>"><%=rs.getString(1)+" "+ rs.getString(2) + " "+ rs.getString(3) + rs.getString(4)%></option>
        
                <%
                }
               rs.close();
                pstmt.close();
           %>
                  </select></td>
                  
                  
          <td><select id="cal_<%=i%>"> 
                  
                  
          <%
                pstmt = con.prepareStatement("select * from l_horarios");
                rs = pstmt.executeQuery();
                while(rs.next()){
              
                %>
                
                
                <option value="<%=rs.getInt(1)%>"> <%=rs.getString(2)%></option> 
                  
      <%
                }
               rs.close();
                pstmt.close();
           %>
                  </select></td>
          </tr> 
          <%}%>
     </table>
     
     <button onclick="addGrupo()">Add </button> <button onclick="$('#profesores').show()"> ver profesores </button>
       
     <div class="fin">  <span class="sig" onclick=" guardarGrupos(4);  "> >></span> </div>     
  </div>  


<div id="profesores" class="emeregente">
    <span onclick="$('#profesores').hide()">tache</span>
    Profesores
    
    <table>
        <tr><td>Nombre</td><td>Habiitado</td></tr> 
       
       
        <%
       pstmt = con.prepareStatement("select * from l_profesores");
           
           
            rs = pstmt.executeQuery();
            
       
            
                while(rs.next()){
              
                %>
                
                <tr><td><%=rs.getString(1)+" "+ rs.getString(2) + " "+ rs.getString(3) + rs.getString(4)%></td><td> <%=(rs.getBoolean(5))?"<input type='checkbox' checked>":"<input type='checkbox'>"%></td></tr>
        
                <%
                }
               rs.close();
                pstmt.close();
           %>
        
    </table>

</div>

<div id="i_4" class="inicioS" > 
    <div class="tituli">5. Subir alumnos </div>
    <input type='file' name='archivoAl' id='archivoAl' />

    <input type='button' id='botonSubidor' onclick="sendFile('archivoAl','control/alumnos/cargarAlumnos.jsp');" />
  
    <div class="fin"  >  <span class="sig" onclick="$('#i_4').hide(); $('#i_5').show();" >>></span></div>  
</div>

<div id="i_5" class="inicioS"> 
    <div class="tituli"> </div>
    Los datos se han registrado con exito, puede hacer modificaciones y/o  consultas por medio del
    menu de catalogos.
    <div class="fin" onclick="$('#i_5').hide(); ">Aceptar</div>  
</div>