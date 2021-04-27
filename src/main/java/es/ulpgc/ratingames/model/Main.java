/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package es.ulpgc.ratingames.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author yusef
 */
public class Main {
    
    public static void main (String [ ] args) throws ClassNotFoundException, InstantiationException, IllegalAccessException {

            String username = "pepe";
            String password = "hoho";
            String correo = "jiji";
        Connection conexion = null;
        try{
            conexion = DriverManager.getConnection ("jdbc:mysql://localhost:3307/ratingames","root", "admin");

            if(!conexion.isValid(1)){

                System.out.println("baaaaaaaaaaaaad");

            }

        }catch(SQLException ex){

        }

        try{
            
            Statement s = conexion.createStatement();
                ResultSet rs = s.executeQuery ("SELECT*FROM user where username=" + "'" + "yusef" + "'");
                
                while(rs.next()){
                    System.out.println(rs.getString("username"));
                    
                }
                
                Integer rs2 = s.executeUpdate("INSERT INTO user (username, password, email)"
                            + " VALUES ('" +username + "', '" + password + "', '" + correo +"')");   
                if(rs2 > 0){
                    System.out.println("CREADO");
                }
            
        }catch(SQLException e){}


 

    } //Cierre del main   
}
