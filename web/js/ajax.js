
function myOAjax(){
var xmlhttp;
    if (window.XMLHttpRequest){// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp=new XMLHttpRequest();
    }else{
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    
    return  xmlhttp;
}

function contenido(seccion,pagina){
    
    var xmlhttp = myOAjax();
    xmlhttp.onreadystatechange=function(){
        if (xmlhttp.readyState==4 && xmlhttp.status==200){
             if(seccion!=''){
            document.getElementById(seccion).innerHTML=xmlhttp.responseText;
             }else{
                   document.write(xmlhttp.responseText);
             }
        }else{
            
            if(xmlhttp.status==404) contenido(seccion,pagina);
            
            /*if(seccion!=''){
             document.getElementById(seccion).innerHTML='<img src="js/wait.gif" width="16" height="16"> ';
            }else{
                 document.location.target = "_blank";
             document.location.href='index.jsp';
            }*/
        }
    };
  
    
  
    xmlhttp.open("POST",pagina,true);
    xmlhttp.send();
    
   // setTimeout(activarBoton,500);
    
  };
  
  
  /*
   * 
   * @param {type} seccion
   * @param {type} pagina
   * @param {type} param
   * @returns {undefined}
   * 
   * Retorna la variable param
   */
function contenidoP(seccion,pagina,param){
  // var txt = '12 12 12 12';
    var xmlhttp = myOAjax();
    xmlhttp.onreadystatechange=function(){
        if (xmlhttp.readyState==4 && xmlhttp.status==200){
            document.getElementById(seccion).innerHTML=xmlhttp.responseText;
         // resultado = xmlhttp.responseText;
        }else{
             document.getElementById(seccion).innerHTML='<img src="js/wait.gif" width="16" height="16">';
        }
    };
  
        xmlhttp.open("POST",pagina,true);
        xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded")
        xmlhttp.send('&param='+param);
       // document.getElementById(seccion).innerHTML=resultado;
      /*
        var a = txt.split(" ");
        for(var i=0; i<a.length; i++) {a[i] = +a[i]; }   
        b = ['a', 'b', 'c', 'd'];
        c = resultado.split(" ");
        setTimeout (function(){graficar(a,b,'chart2')}, 500);
       // setTimeout (function(){alert(c[0])}, 700);
        */
  };
  /*
   * 
   * @param {type} fileName
   * @param {type} url
   * @returns {undefined}
   * 
   * Esta función no retorna una vista, solo modifica la variable ajax_res;
   * 
   */
    ajax_res="";
function pasarParamertros(xjsp,param){
   
    var xmlhttp = myOAjax();
    xmlhttp.onreadystatechange=function(){
        if (xmlhttp.readyState==4 && xmlhttp.status==200){
           ajax_res= xmlhttp.responseText;
           
        }else{
             
        }
    };
        xmlhttp.open("POST",xjsp,true);
        xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded")
        xmlhttp.send(param);
       
 
  };
  
  
  function getForm(nameForm){
      cadena = "";
      
  
      for (x in nameForm.elements){
            
             if(nameForm.elements[x].type == "text"){
                        
                        cadena = cadena + '&'+nameForm.elements[x].name  + '='+  nameForm.elements[x].value;
                        
                }
              
                if(nameForm.elements[x].type == "radio"){
                        if(nameForm.elements[x].checked==true){
                        cadena = cadena + '&'+nameForm.elements[x].name  + '='+  nameForm.elements[x].value;
                        }
                }
                else if((nameForm.elements[x].type == "textarea")){
                     cadena = cadena + '&'+ nameForm.elements[x].name  + '='+  nameForm.elements[x].value;

                }else if((nameForm.elements[x].type == "checkbox")){
                      if(nameForm.elements[x].checked==true){
                     cadena = cadena + '&'+ nameForm.elements[x].name  + '='+  nameForm.elements[x].value;
                      } else  cadena = cadena + '&'+ nameForm.elements[x].name  + '='+  '';
                }else{
                }  
            
    
          }
            
  return cadena;
  
  };
  
  function sendForm(nameForm,pagina,seccion){
      // validarForm(nameForm);
      
      
         cadena = getForm(nameForm);
         //alert(cadena);
      
      
      var xmlhttp = myOAjax();
    xmlhttp.onreadystatechange=function(){
        if (xmlhttp.readyState==4 && xmlhttp.status==200){
            document.getElementById(seccion).innerHTML=xmlhttp.responseText;
        }else{
             document.getElementById(seccion).innerHTML='<img src="js/wait.gif" width="16" height="16">';
        }
    };
  	
    
        xmlhttp.open("POST",pagina,true);
        xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded")
        xmlhttp.send(cadena);
  
  }
  
    
  function sendCadena(cadena,pagina,seccion){
      
      var xmlhttp = myOAjax();
      xmlhttp.onreadystatechange=function(){
        if (xmlhttp.readyState==4 && xmlhttp.status==200){
            document.getElementById(seccion).innerHTML=xmlhttp.responseText;
        }else{
             document.getElementById(seccion).innerHTML='<img src="js/wait.gif" width="16" height="16">';
        }
    };
  	
    
        xmlhttp.open("POST",pagina,true);
        xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded")
        xmlhttp.send(cadena);
  
  }
 
  /*
  function sendFile(fileName){

        var inputFileImage = document.getElementById(fileName);

        var file = inputFileImage.files[0];

        var data = new FormData();

        data.append('archivo',file);

        var url ='control/alumnos/cargarAlumnos.jsp';

$.ajax({

url:url,

type:'POST',

contentType:false,

data:data,

processData:false,

cache:false});

}*/

 function sendFile(fileName,url){

        var inputFileImage = document.getElementById(fileName);

        var file = inputFileImage.files[0];

        var data = new FormData();

        data.append('archivo',file);

        //var url =;

$.ajax({

url:url,

type:'POST',

contentType:false,

data:data,

processData:false,

cache:false});

}