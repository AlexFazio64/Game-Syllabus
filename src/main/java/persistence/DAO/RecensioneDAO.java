package persistence.DAO;

import Model.ListaGiochi;
import Model.Recensione;

import java.util.ArrayList;
import java.util.List;

public interface RecensioneDAO {
    void save(Recensione recensione); // CREATE
    Recensione findByPrimaryKey(Integer id); //RETRIEVE
    ArrayList<Recensione> findAll();
    void update (Recensione recensione); // UPDATE
    void delete(Recensione recensione); //DELETE
}
