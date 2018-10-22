package TablasSQL;
public class Misiones {
    private int idMision, idJefe, activo;
    private String Mision, Inicio, Fin, Aprox;

    public int getIdMision() {
        return idMision;
    }

    public void setIdMision(int idMision) {
        this.idMision = idMision;
    }

    public int getIdJefe() {
        return idJefe;
    }

    public void setIdJefe(int idJefe) {
        this.idJefe = idJefe;
    }

    public String getMision() {
        return Mision;
    }

    public void setMision(String Mision) {
        this.Mision = Mision;
    }

    public String getInicio() {
        return Inicio;
    }

    public void setInicio(String Inicio) {
        this.Inicio = Inicio;
    }

    public String getFin() {
        return Fin;
    }

    public void setFin(String Fin) {
        this.Fin = Fin;
    }

    public String getAprox() {
        return Aprox;
    }

    public void setAprox(String Aprox) {
        this.Aprox = Aprox;
    }

    public int getActivo() {
        return activo;
    }

    public void setActivo(int activo) {
        this.activo = activo;
    }    
}
