package persistence.DAO.JDBC;

import Model.ListaGiochi;
import Model.Recensione;
import persistence.DAO.RecensioneDAO;
import persistence.DBManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RecensioneDAOPG implements RecensioneDAO{


    //Funziona
    @Override
    public void save(Recensione recensione) {
        Connection connection;
        try {
            connection = DBManager.getDataSource().getConnection();
            String queryUpdate = "INSERT INTO recensione values(?, ?, ?, ?, ?)";
            PreparedStatement st = connection.prepareStatement(queryUpdate);
            st.setInt(1, recensione.getId());
            st.setInt(2, recensione.getValutazione());
            st.setString(3, recensione.getTesto());
            st.setString(4, recensione.getIdGioco());
            st.setString(5, recensione.getScrittaDa());
            st.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Recensione findByPrimaryKey(Integer id) {
        return null;
    }

    @Override
    public ArrayList<Recensione> findAll() {
        Connection connection;
        ArrayList<Recensione> recensioni = null;
        try {
            connection = DBManager.getDataSource().getConnection();
            recensioni = new ArrayList<>();
            Recensione recensione;
            PreparedStatement statement;
            String query = "select * from recensione";
            statement = connection.prepareStatement(query);
            ResultSet result = statement.executeQuery();
            while (result.next()){
                recensione = new Recensione();
                recensione.setId(result.getInt("id"));
                recensione.setValutazione(result.getInt("valutazione"));
                recensione.setTesto(result.getString("testo"));
                recensione.setIdGioco(result.getString("idGioco"));
                recensione.setScrittoDa(result.getString("scrittaDa"));
                recensioni.add(recensione);
            }
            connection.close();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return recensioni;
    }

    /*Funziona ma da vedere con gli altri*/
    @Override
    public void update(Recensione recensione) {
        Connection connection = null;
        try {
            connection = DBManager.getDataSource().getConnection();
            String update = "UPDATE recensione SET valutazione = ?, testo = ? WHERE id = ?";
            PreparedStatement st = connection.prepareStatement(update);
            st.setInt(1, recensione.getValutazione());
            st.setString(2, recensione.getTesto());
            st.setInt(3, recensione.getId());

            st.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                throw new RuntimeException(e.getMessage());
            }
        }
    }

    //Funziona
    @Override
    public void delete(Recensione recensione) {
        Connection connection = null;
        try {
            connection = DBManager.getDataSource().getConnection();
            String delete = "DELETE FROM recensione WHERE id = ?";
            PreparedStatement st = connection.prepareStatement(delete);
            st.setInt(1, recensione.getId());
            st.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                throw new RuntimeException(e.getMessage());
            }
        }
    }
}
