package persistence.DAO.JDBC;

import Model.Recensione;
import persistence.DAO.RecensioneDAO;
import persistence.DBManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class RecensioneDAOPG implements RecensioneDAO {


    //Funziona
    @Override
    public boolean save(Recensione recensione) {
        Connection connection;
        try {
            connection = DBManager.getDataSource().getConnection();
            String queryUpdate = "INSERT INTO recensione(valutazione, testo,idgioco,scrittada) values( ?, ?, ?, ?)";
            PreparedStatement st = connection.prepareStatement(queryUpdate);
            st.setInt(1, recensione.getValutazione());
            st.setString(2, recensione.getTesto());
            st.setString(3, recensione.getIdGioco());
            st.setString(4, recensione.getScrittaDa());
            st.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

    }

    @Override
    public ArrayList<Recensione> findAllByEmail(String email) {
        Connection connection;
        ArrayList<Recensione> recensioni = new ArrayList<>();
        try {
            connection = DBManager.getDataSource().getConnection();
            Recensione recensione;
            PreparedStatement statement;
            String query = "select * from recensione where scrittada = ? ORDER BY Id DESC ";
            statement = connection.prepareStatement(query);
            statement.setString(1, email);
            ResultSet result = statement.executeQuery();
            while (result.next()) {
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

    @Override
    public Recensione findReviewByEmail(String email, String idGame) {
        Connection connection;
        Recensione recensione = null;
        try {
            connection = DBManager.getDataSource().getConnection();
            PreparedStatement statement;
            String query = "select * from recensione where scrittada = ? and idgioco=? ";
            statement = connection.prepareStatement(query);
            statement.setString(1, email);
            statement.setString(2, idGame);
            ResultSet result = statement.executeQuery();
            while (result.next()) {
                recensione = new Recensione();
                recensione.setId(result.getInt("id"));
                recensione.setValutazione(result.getInt("valutazione"));
                recensione.setTesto(result.getString("testo"));
                recensione.setIdGioco(result.getString("idGioco"));
                recensione.setScrittoDa(result.getString("scrittaDa"));
            }
            connection.close();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return recensione;

    }

    @Override
    public ArrayList<Recensione> findAllByIdGame(String idGame) {
        Connection connection;
        ArrayList<Recensione> recensioni = new ArrayList<>();
        try {
            connection = DBManager.getDataSource().getConnection();
            Recensione recensione;
            PreparedStatement statement;
            String query = "select * from recensione where idgioco = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, idGame);
            ResultSet result = statement.executeQuery();
            while (result.next()) {
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
            while (result.next()) {
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

    @Override
    public boolean update(Recensione recensione) {
        Connection connection = null;
        try {
            connection = DBManager.getDataSource().getConnection();
            String update = "UPDATE recensione SET valutazione = ?, testo = ? WHERE id = ?";
            PreparedStatement st = connection.prepareStatement(update);
            st.setInt(1, recensione.getValutazione());
            st.setString(2, recensione.getTesto());
            st.setInt(3, recensione.getId());
            st.executeUpdate();
            connection.close();
            return true;
        } catch (SQLException e) {
            return false;
        }
    }


    @Override
    public boolean delete(Recensione recensione) {
        Connection connection = null;
        try {
            connection = DBManager.getDataSource().getConnection();
            String delete = "DELETE FROM recensione WHERE id = ?";
            PreparedStatement st = connection.prepareStatement(delete);
            st.setInt(1, recensione.getId());
            st.executeUpdate();
            connection.close();
            return true;
        } catch (SQLException e) {
            return false;
        }
    }
}
