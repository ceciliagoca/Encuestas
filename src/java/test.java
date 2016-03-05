
import ABC.ABCAlumnos;
import ABC.ABCEncuestas;
import ABC.ABCSemestre;

import entity.Alumno;
import entity.Encuesta;
import ABC.Indicadores;

import entity.Preguntas;
import entity.Profesor;
import entity.Usuario;
import java.io.FileNotFoundException;
import java.sql.SQLException;
import java.util.Iterator;
import utils.CSV2BD;
import utils.Conexion;
import utils.Correo;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Cecilia
 */
public class test {
    
   
    
   
    public static void main(String[] args) throws SQLException, FileNotFoundException{
        ABCAlumnos alumnos = new ABCAlumnos();
       CSV2BD csv2bd = new CSV2BD();
       
       //csv2bd.cargarAlumnos();
        
    }
}
