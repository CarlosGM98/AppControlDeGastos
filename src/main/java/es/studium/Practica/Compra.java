package es.studium.Practica;

import java.util.Date;

public class Compra {
    private int idCompra;
    private Date fechaCompra;
    private double importeCompra;
    private int idUsuarioFK;
    private int idTiendaFK;

    // Constructores
    public Compra() {}

    public Compra(int idCompra, Date fechaCompra, double importeCompra, int idUsuarioFK, int idTiendaFK) {
        this.idCompra = idCompra;
        this.fechaCompra = fechaCompra;
        this.importeCompra = importeCompra;
        this.idUsuarioFK = idUsuarioFK;
        this.idTiendaFK = idTiendaFK;
    }

    // Getters y Setters
    public int getIdCompra() {
        return idCompra;
    }

    public void setIdCompra(int idCompra) {
        this.idCompra = idCompra;
    }

    public Date getFechaCompra() {
        return fechaCompra;
    }

    public void setFechaCompra(Date fechaCompra) {
        this.fechaCompra = fechaCompra;
    }

    public double getImporteCompra() {
        return importeCompra;
    }

    public void setImporteCompra(double importeCompra) {
        this.importeCompra = importeCompra;
    }

    public int getIdUsuarioFK() {
        return idUsuarioFK;
    }

    public void setIdUsuarioFK(int idUsuarioFK) {
        this.idUsuarioFK = idUsuarioFK;
    }

    public int getIdTiendaFK() {
        return idTiendaFK;
    }

    public void setIdTiendaFK(int idTiendaFK) {
        this.idTiendaFK = idTiendaFK;
    }
}
