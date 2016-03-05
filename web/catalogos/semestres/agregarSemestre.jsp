 <%@page import="entity.Profesor"%>
<%@page import="java.util.Iterator"%>
<div id="err_mensaje">  </div>


<h1>Nuevo semestre</h1>


<div id="sem1">
 
         <h2> Elegir las fechas de inicio y fin de semestre: </h2>
          
          <table> 
          <tr>
              <td>     De:   <input type="text" id="cfrom" name="cfrom"  onmouseover="calendarioRange('cfrom', 'cto');"/>  </td>
            <td>  a:   <input type="text" id="cto" name="cto" onchange="calSemestre('cfrom', 'cto')"/>  </td> <td> <div id="t_smestre_aux"></div></td>
          </tr>
           
          </table>
</div>

<jsp:useBean id="ABCprofesor" scope="page" class="ABC.ABCProfesores" />
<jsp:useBean id="profesor" scope="page" class="entity.Profesor" />

<% Iterator<Profesor> l_profesor= ABCprofesor.listarProfesores().iterator(); %>
<div id="sem2">

     <h2> Agregar grupos </h2>
                <table id="sem_profesores">
                    <tr> <td> Grupo:</td> <td> <input name="grupo" type="text" >  </td>  
                         <td> Profesor:</td> <td> <select name="rfc" > 
                                 <% while (l_profesor.hasNext()){ %>
                                         <% profesor = (Profesor)l_profesor.next(); %>
                                 <option>  <%=profesor.getTitulo() + " " + profesor.getNombre() + " "  + profesor.getApeP() + " "+ profesor.getApeM() %> </option> 
                                 <%}%>
                             </select> </td>  
                         <td> Horario :</td> <td> <select name="horario" > <option></option> </select>  </td> 
                    </tr>
                    
                </table>
                
                <center> <button class="form_btn" type="button" onclick="addProfesor(this.form)"> Agregar </button> </center>
     
     <button type="button" onclick="hideShow('sem2', 'sem1')"> Atras </button>
     <button type="button" onclick="hideShow('sem2', 'sem3')"> Siguiente </button>
</div>