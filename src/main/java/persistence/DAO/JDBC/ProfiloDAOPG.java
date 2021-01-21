package persistence.DAO.JDBC;

import Model.Profilo;
import persistence.DAO.ProfiloDAO;
import persistence.DBManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProfiloDAOPG implements ProfiloDAO {
	
	@Override
	public boolean save(Profilo profilo) {
		Connection conn = null;
		try {
			conn = DBManager.getDataSource().getConnection();
			String query = "INSERT INTO profilo (email, password, username, descrizione, immagine) VALUES (?, ?, ?, ?, ?);";
			PreparedStatement row = conn.prepareStatement(query);
			row.setString(1, profilo.getEmail());
			row.setString(2, profilo.getPassword());
			row.setString(3, profilo.getUsername());
			row.setString(4, profilo.getDescrizione());
			row.setBytes(5, profilo.getImmagine());
			boolean r = row.executeUpdate() != 0;
			conn.close();
			return r;
		} catch (SQLException throwables) {
			throwables.printStackTrace();
			return false;
		}
	}
	
	@Override
	public Profilo findByPrimaryKey(String email) {
		Connection conn = null;
		try {
			conn = DBManager.getDataSource().getConnection();
			String query = "SELECT * FROM profilo WHERE email = ?;";
			PreparedStatement row = conn.prepareStatement(query);
			row.setString(1, email);
			ResultSet res = row.executeQuery();
			conn.close();
			if ( res.next() ) {
				Profilo found = new Profilo();
				found.setEmail(res.getString("email"));
				found.setPassword(res.getString("password"));
				found.setUsername(res.getString("username"));
				found.setDescrizione(res.getString("descrizione"));
				found.setImmagine(res.getBytes("immagine"));
				return found;
			}
		} catch (SQLException throwables) {
			throwables.printStackTrace();
		}
		return null;
	}
	
	@Override
	public Profilo findByUsername(String username) {
		Connection conn = null;
		try {
			conn = DBManager.getDataSource().getConnection();
			String query = "SELECT * FROM profilo WHERE username = ?;";
			PreparedStatement row = conn.prepareStatement(query);
			row.setString(1, username);
			ResultSet res = row.executeQuery();
			conn.close();
			if ( res.next() ) {
				Profilo found = new Profilo();
				found.setEmail(res.getString("email"));
				found.setPassword(res.getString("password"));
				found.setUsername(res.getString("username"));
				found.setDescrizione(res.getString("descrizione"));
				found.setImmagine(res.getBytes("immagine"));
				return found;
			}
		} catch (SQLException throwables) {
			throwables.printStackTrace();
		}
		return null;
	}
	
	@Override
	public List<Profilo> findAll() {
		Connection conn = null;
		try {
			conn = DBManager.getDataSource().getConnection();
			String query = "SELECT * FROM profilo;";
			PreparedStatement row = conn.prepareStatement(query);
			ResultSet res = row.executeQuery();
			ArrayList<Profilo> all = new ArrayList<>();
			conn.close();
			while (res.next()) {
				Profilo found = new Profilo();
				found.setEmail(res.getString("email"));
				found.setPassword(res.getString("password"));
				found.setUsername(res.getString("username"));
				found.setDescrizione(res.getString("descrizione"));
				found.setImmagine(res.getBytes("immagine"));
				all.add(found);
			}
			
			return all;
		} catch (SQLException throwables) {
			throwables.printStackTrace();
		}
		return null;
	}
	
	@Override
	public boolean update(Profilo profilo) {
		Connection conn = null;
		try {
			conn = DBManager.getDataSource().getConnection();
			String query = "UPDATE profilo SET email =?,password =?,username =?, descrizione =?,immagine =? WHERE email = ?;";
			PreparedStatement row = conn.prepareStatement(query);
			row.setString(1, profilo.getEmail());
			row.setString(2, profilo.getPassword());
			row.setString(3, profilo.getUsername());
			row.setString(4, profilo.getDescrizione());
			row.setBytes(5, profilo.getImmagine());
			row.setString(6, profilo.getEmail());
			boolean r = row.executeUpdate() != 0;
			conn.close();
			return r;
		} catch (SQLException throwables) {
			throwables.printStackTrace();
		}
		return false;
	}
	
	@Override
	public boolean delete(String email) {
		Connection conn = null;
		try {
			conn = DBManager.getDataSource().getConnection();
			String query = "DELETE * FROM profilo WHERE email = ?;";
			PreparedStatement row = conn.prepareStatement(query);
			row.setString(1, email);
			boolean r = row.executeUpdate() != 0;
			conn.close();
			return r;
		} catch (SQLException throwables) {
			throwables.printStackTrace();
		}
		return false;
	}
}