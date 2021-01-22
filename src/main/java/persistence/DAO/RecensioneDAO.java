package persistence.DAO;

import Model.ListaGiochi;
import Model.Recensione;

import java.util.ArrayList;
import java.util.List;

public interface RecensioneDAO {
    void save(Recensione recensione); // CREATE
    ArrayList<Recensione> findAllByEmail(String email); //RETRIEVE da usare nel profilo
    Recensione findReviewByEmail(String email,String idGame);
    ArrayList<Recensione> findAllByIdGame(String idGame);
    ArrayList<Recensione> findAll();
    void update (Recensione recensione); // UPDATE
    void delete(Recensione recensione); //DELETE
}
