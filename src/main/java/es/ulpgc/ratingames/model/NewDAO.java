package es.ulpgc.ratingames.model;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.http.HttpServletResponse;
public class NewDAO {    
    ResultSet rs;
    public void listarIMG(int idNew, HttpServletResponse response){
        String sql ="select * from new where id = " + idNew;
        try{
            Conexion con = new Conexion();
            Connection c = con.getConnection();
            PreparedStatement ps = c.prepareStatement(sql);
            InputStream is = null;
            OutputStream os = null;
            BufferedInputStream bis = null;
            BufferedOutputStream bos = null;
            response.setContentType("image/*");
            os = response.getOutputStream();
            rs = ps.executeQuery();
            if(rs.next()){
                is = rs.getBinaryStream("image");
            }
            bis = new BufferedInputStream(is);
            bos = new BufferedOutputStream(os);
            int i = 0;
            while( (i = bis.read()) != -1 ){
                bos.write(i);
            }
           }catch(IOException | SQLException e){}
    }
    public void agregar(New n){
        String sql = "INSERT INTO new(journalistId,title,body,image,date)"
                + " VALUES (?,?,?,?,?)";        
        try{
            Conexion con = new Conexion();
            Connection c = con.getConnection();
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setInt(1, n.getJournalist());
            ps.setString(2, n.getTitle());
            ps.setString(3, n.getBody());
            ps.setBlob(4, n.getImage());
            ps.setDate(5, new java.sql.Date(new java.util.Date().getTime()));  
            ps.executeUpdate();
        }catch(SQLException e){
            System.out.println(e);
        }
    }
    public void eliminar(int newId){
        String sql = "DELETE FROM new WHERE id="+ newId;
        try{
            Conexion con = new Conexion();
            Connection c = con.getConnection();
            Statement ps = c.createStatement();
            ps.executeUpdate(sql);           
        }catch(SQLException e){}
    }
    private class Conexion {
        Connection con;
        public Connection getConnection(){
            try{
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection ("jdbc:mysql://localhost:3307/ratingames","root", "");
            }catch(Exception ex){}
            return con;
        }
    }
}


