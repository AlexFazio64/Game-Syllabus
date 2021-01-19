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


    @Override
    public void save(Recensione recensione) {

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

    @Override
    public void update(Recensione recensione) {

    }

    @Override
    public void delete(Recensione recensione) {

    }
}
