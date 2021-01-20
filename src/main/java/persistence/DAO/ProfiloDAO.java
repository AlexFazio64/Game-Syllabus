package persistence.DAO;

import Model.Profilo;

import java.util.List;

public interface ProfiloDAO {

    boolean save(Profilo profilo); // CREATE
    Profilo findByPrimaryKey(String email); //RETRIEVE
    Profilo findByUsername(String username); //NEEDED
    List<Profilo> findAll();
    void update (Profilo profilo); // UPDATE
    void delete(String emailUtente); //DELETE


}
