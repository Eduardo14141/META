package Java;

import TablasSQL.Comentario;
import TablasSQL.Vinculo;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class AccionesTutor {
    public static List<Vinculo> getAllVinculosById(int idTutor){
        List<Vinculo> lista= new ArrayList<Vinculo>();
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q="select * from vinculos where idTutor=?";
                PreparedStatement ps = con.prepareStatement(Q);
                ps.setInt(1, idTutor);
                ResultSet rs= ps.executeQuery();
                while(rs.next()){
                    Vinculo m= new Vinculo();
                    m.setIdVinculo(rs.getInt(1));
                    m.setIdAlumno(rs.getInt(2));
                    m.setIdTutor(rs.getInt(3));
                    m.setActivo(rs.getInt(4));
                    lista.add(m);
                }
            }
        }catch(SQLException d){
            System.out.println("Error al obtener vinculos tutor");
            System.out.println(Arrays.toString(d.getStackTrace()));
            System.out.println(d.getMessage());
        }
        return lista;
    }
    public static List<Comentario> getComentariosTareaByIdTarea(int idTarea, int idTutor){
        List<Comentario> lista= new ArrayList<Comentario>();
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q="select * from comentarios where idTarea=? and idTutor=?";
                PreparedStatement ps = con.prepareStatement(Q);
                ps.setInt(1, idTarea);
                ps.setInt(2, idTutor);
                ResultSet rs= ps.executeQuery();
                while(rs.next()){
                    Comentario m= new Comentario();
                    m.setIdComentario(rs.getInt(1));
                    m.setComentario(rs.getString(2));
                    m.setIdTutor(rs.getInt(3));
                    m.setIdTarea(rs.getInt(4));
                    m.setActivo(rs.getInt(5));
                    lista.add(m);
                }
            }
        }catch(SQLException d){
            System.out.println("Error al obtener ComentariosTarea");
            System.out.println(Arrays.toString(d.getStackTrace()));
            System.out.println(d.getMessage());
        }
        return lista;
    }
    public static int Comentar(Comentario e){
        int status=0;
        try{
            try (Connection con = ConexiónBD.getConnection()) {
                String Q;
                Q="insert into comentarios (comentario, idTutor, idTarea, CActivo) values(?,?,?,?)";
                PreparedStatement ps = con.prepareStatement(Q);
                ps.setString(1, e.getComentario());
                ps.setInt(2, e.getIdTutor());
                ps.setInt(3, e.getIdTarea());
                ps.setInt(4, 1);
                status=ps.executeUpdate();
            }
        }catch(SQLException d){
            System.out.println("Hubo un error al actualizar los datos");
            System.out.println(Arrays.toString(d.getStackTrace()));
            System.out.println(d.getMessage());
        }
        return status;
    }
}