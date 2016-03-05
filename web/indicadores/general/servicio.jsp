
<h1>Indicadores de servicio</h1>

<jsp:useBean id="indicador" scope="page" class="ABC.Indicadores" />
<jsp:useBean id="semestre" scope="session" class="ABC.ABCSemestre" />

<%indicador.setSemestre(semestre.getCurrent()); %>
<%=indicador.getSemestre() %>





 <h1> Objetivos de calidad</h1>

 
 
 <table>
     <thead><tr><th> No.  </th><th > Indicador </th><th> Resultado </th> <th> Meta </th></tr></thead>
     <tbody>
         <tr> 
             <td> 1 </td> 
             <td class="indicador"> 
                Número de preguntas calificadas con 10 u 8 en la  "Encuesta de evaluación"   <hr>
                Total de preguntas calificadas
             </td> 
                  <td><%=indicador.iservicio(1)%> </td> <td>  80% </td> 
         </tr>    
         
     
         
         <tr> 
             <td> 2 </td> 
             <td class="indicador"> 
                Calificación promedio de la preguntas 4a, 4b, 4c y 4d en "Encuesta de evaluación del servicio"  x 10
             </td> 
             <td><%=indicador.iservicio(2)%> </td> <td>  80% </td> 
         </tr>   
         
                <tr> 
             <td> 3 </td> 
             <td class="indicador"> 
                profesores con calificaciones mayores a 80 <hr> Número de profesores
             </td> 
             <td>  </td> <td>  80% </td> 
         </tr>   
         
         
                <tr> 
             <td> 6 </td> 
             <td class="indicador"> 
                Calificación de la pregunta 11 de la "Encuesta de evaluación del servicio"
             </td> 
             <td> <%=indicador.iservicio(6)%>  </td> <td>  80% </td> 
         </tr>  
         
         
         
     </tbody>    
 </table>
 
         
 <h1> Proceso de realización</h1>

 <table>
     <thead><tr><th> No.  </th><th > Indicador </th><th> Resultado </th> <th> Meta </th></tr></thead>
     <tbody>
         <tr> 
             <td> 10 </td> 
             <td class="indicador"> Calificación promedio de la pregunta 1 de la "Encuesta de evaluación del servicio"
             </td> 
                  <td><%=indicador.iservicio(10)%> </td> <td>  80% </td> 
         </tr>    
         
     
         
         <tr> 
             <td> 11 </td> 
             <td class="indicador"> 
                Número de fallas atendidas de la pregunta 9 de la encuesta "Evaluación del servicio" <hr>
                Número total de fallas presentadas de la pregunta 9 de la  encuesta de "Evaluación del servicio"
             </td> 
             <td><!--%=indicador.iservicio(11)%--></td> <td>  80% </td> 
         </tr>   
         
                <tr> 
             <td> 12 </td> 
             <td class="indicador"> 
                Calificación promedio de la pregunta 7  de la  encuesta de "Evaluación del servicio"
             </td> 
             <td>  <%=indicador.iservicio(12)%></td> <td>  80% </td> 
         </tr>   
         
         
                <tr> 
             <td> 13 </td> 
             <td class="indicador"> 
                Calificación de la pregunta 8  de la "Encuesta de evaluación del servicio"
             </td> 
             <td>  <%=indicador.iservicio(13)%></td> <td>  80% </td> 
         </tr>  
         
         
         
                <tr> 
             <td> 14 </td> 
             <td class="indicador"> 
                Calificación de la pregunta 6  de la "Encuesta de evaluación del servicio"
             </td> 
             <td> <%=indicador.iservicio(14)%> </td> <td>  80% </td> 
         </tr>  
            <tr> 
             <td> 15 </td> 
             <td class="indicador"> 
         Calificación promedio de la pregunta 9 de la encuesta de  "Evaluación del servicio"
         </td> 
             <td> <%=indicador.iservicio(15)%> </td> <td>  80% </td> 
         </tr>  
     </tbody>    
 </table>
          <h1>   Responsabilidad directiva </h1>
         
          <table>
     <thead><tr><th> No.  </th><th > Indicador </th><th> Resultado </th> <th> Meta </th></tr></thead>
     <tbody>
         <tr> 
             <td> 21 </td> 
             <td class="indicador"> Calificación promedio de la pregunta 10 de la "Encuestas de evaluación del servicio"
             </td> 
                  <td><%=indicador.iservicio(6)%> </td> <td>  80% </td> 
         </tr>    
         
     
     </tbody>    
 </table>