




import ABC.ABCAlumnos;
import ABC.Indicadores;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;

import utils.CSV2BD;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Cecilia
 */
public class Prueba {
    public static void main(String[] args) throws SQLException, FileNotFoundException, IOException{
   
ABC.Indicadores ind  = new Indicadores();
ind.setSemestre("2015-1");

ind.promedioPracticas(10);
   //  ABC.ABCAlumnos alumn= new ABCAlumnos();
   //  alumn.arreglarAlumno();
// CSV2BD c= new CSV2BD();
    //c.repararComentarios();
    //c.repararBuzon();
   // c.repararPracticas();
    // c.cargarCalendarizacion("2015-1");
 // CV
        
    }
}
    //Alumno alumno =  new Alumno("21565656","levap");
    //alumno.registrarAlumno();
    
    //Cuestionario cuestionario = new Cuestionario(2, "salidas autoenclavadas", Date.valueOf("2013-08-19"),Date.valueOf("2013-08-23"),"A");
    //cuestionario.registrarCuestionario();
        
        //Preguntas cues= new Preguntas("21565656", 1, 1, 10, "nada");
        //cues.registrarPregunta();
        //cues = new Preguntas("21565656", 1, 2, 10, "nada");
        /*cues.registrarCuestionario();
        cues = new Preguntas("21565656", 1, 3, 10, "nada");
        cues.registrarCuestionario();
        cues = new Preguntas("21565656", 1, 4, 10, "nada");
        cues.registrarCuestionario();
        cues = new Preguntas("21565656", 1, 5, 10, "nada");
        cues.registrarCuestionario();
        cues = new Preguntas("21565656", 1, 6, 10, "nada");
        cues.registrarCuestionario();
        cues = new Preguntas("21565656", 1, 7, 10, "nada");
        cues.registrarCuestionario();
        cues = new Preguntas("21565656", 1, 8, 10, "nada");
        cues.registrarCuestionario();
        cues = new Preguntas("21565656", 1, 9, 10, "nada");
        cues.registrarCuestionario();
        cues = new Preguntas("21565656", 1, 10, 10, "nada");
        cues.registrarCuestionario();
        cues = new Preguntas("21565656", 1, 11, 10, "nada");
        cues.registrarCuestionario();
        cues = new Preguntas("21565656", 1, 12, 0, "nada");
        cues.registrarCuestionario();
        cues = new Preguntas("21565656", 1, 13, 0, "nada");
        cues.registrarCuestionario();
        cues = new Preguntas("21565656", 1, 14, 0, "nada");
        cues.registrarCuestionario();
        cues = new Preguntas("21565656", 1, 15, 0, "nada");
        cues.registrarCuestionario();
        cues = new Preguntas("21565656", 1, 16, 8, "nada");
        cues.registrarCuestionario();
        cues = new Preguntas("21565656", 1, 17, 8, "nada");
        cues.registrarCuestionario();
        cues = new Preguntas("21565656", 1, 18, 0, "nada");
        cues.registrarCuestionario();
        cues = new Preguntas("21565656", 1, 19, 0, "nada");
        cues.registrarCuestionario();
       */
        
       //Indicadores in = new Indicadores();
       //in.iprac_proceso(2);
       
      /* Preguntas p = new Preguntas();
       p.setIdAlumno("305108809");
       p.setIdCuestionario(1);
       p.registrarEncusta();
        
        
        }*/
   
    
  
            //}
