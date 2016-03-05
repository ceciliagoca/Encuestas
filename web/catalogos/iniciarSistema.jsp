


<div id="i_1" class="inicioS" style="display: block">
    <div class="tituli">1. Ingresa semestre </div>
    
    Ingresa fechas de inicio y fin de semestre.
    
    <label for="cfrom">De</label>
    <input type="text" id="cfrom" name="cfrom"  onmouseover="calendarioRange('cfrom', 'cto');"/>
    <label for="cto">a</label>
    <input type="text" id="cto" name="cto" onchange="calSemestre('cfrom', 'cto')"/>
    
    <input type="text" id="t_semestre"/>
    Si el semestre no es correcto favor de corregirlo
 
    <div class="fin">  <span class="sig" onclick=" $('#semT').after($('#t_semestre').val());$('#i_1').hide(); $('#i_2').show(); "> >> </span></div>
    </div>   

<div id="i_2" class="inicioS"> 
    <div class="tituli">2. Subir calendarizaci&oacute;n <br> Semestre: <span id="semT"></span> </div>
        
    <input type='file' name='archivoCal' id='archivoCal' />
    <button  id='botonSubidor' onclick="subirCalendarizacion()">Subir archivo  </button>
    
    <button  id='botonSubidor' onclick="catPracticas()">Ver practicas</button>
    <div class="fin" >  <span class="sig">>></span></div>  
  
</div >


<div id="aux_inicio">
  
</div>    

