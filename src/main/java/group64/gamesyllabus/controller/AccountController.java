package group64.gamesyllabus.controller;

import Model.ListaGiochi;
import Model.Profilo;
import Model.Recensione;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Base64Utils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import persistence.DAO.JDBC.ListaGiochiDAOPG;
import persistence.DAO.JDBC.ProfiloDAOPG;
import persistence.DAO.JDBC.RecensioneDAOPG;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

@Controller
public class AccountController {
	
	private boolean isNotLogged(String username, HttpSession session) {
		return session.getAttribute("usernameLogged") == null || !session.getAttribute("usernameLogged").toString().equals(username);
	}
	
	@GetMapping(path = "/account/{username}")
	public String getAccount(@PathVariable("username") String username, Model model, HttpSession session) {
		if ( isNotLogged(username, session) ) {
			return "redirect:/";
		}
		
		ArrayList<ListaGiochi> personalList;
		personalList = new ListaGiochiDAOPG().findByPrimaryKey(session.getAttribute("emailLogged").toString());
		model.addAttribute("showlist", personalList);
		
		RecensioneDAOPG recdaopg = new RecensioneDAOPG();
		ArrayList<Recensione> rec = recdaopg.findAllByEmail(session.getAttribute("emailLogged").toString());
		if ( rec.size() > 0 ) {
			StringBuilder ids = new StringBuilder();
			rec.forEach(e -> ids.append(e.getIdGioco()).append(","));
			ids.deleteCharAt(ids.lastIndexOf(","));
			model.addAttribute("ids", ids.toString());
		}
		
		model.addAttribute("reviews", rec);
		ProfiloDAOPG daopg = new ProfiloDAOPG();
		Profilo profilo = daopg.findByUsername(username);
		
		model.addAttribute("password", session.getAttribute("googleLogin"));
		model.addAttribute("username", profilo.getUsername());
		
		String descrizione = profilo.getDescrizione();
		model.addAttribute("descrizione", descrizione == null || descrizione.equals("") ? null : descrizione);
		
		if ( profilo.getImmagine() != null ) {
			model.addAttribute("immagine", "data:image/*;base64," + Base64Utils.encodeToString(profilo.getImmagine()));
		} else {
			model.addAttribute("style", (int) ( Math.random() * 100 ) % 5 + 1);
		}
		
		return "profile";
	}
	
	@PostMapping("/account/{username}/edit")
	public String editAccount(HttpSession session, @RequestParam String password, @RequestParam String new_password, @PathVariable("username") String usr, @RequestParam String username, @RequestParam String descrizione, @RequestParam MultipartFile image, Model model) {
		if ( isNotLogged(usr, session) ) {
			return "redirect:/";
		}
		
		Profilo updated = new Profilo();
		ProfiloDAOPG daopg = new ProfiloDAOPG();
		
		if ( session.getAttribute("googleLogin") == null ) {
			if ( !password.equals("") ) {
				if ( !BCrypt.checkpw(password, daopg.findByUsername(usr).getPassword()) ) {
					//password is wrong
					model.addAttribute("error", true);
					model.addAttribute("error_message", "Invalid Credentials");
					return "redirect:/account/" + usr;
				} else {
					if ( !new_password.equals("") ) {
						//wants to change password
						password = new_password;
					}
					updated.setPassword(BCrypt.hashpw(password, BCrypt.gensalt(12)));
				}
			} else {
				//no password to confirm
				model.addAttribute("error", true);
				model.addAttribute("error_message", "Please, insert your password to confirm");
				return "redirect:/account/" + usr;
			}
		} else {
			updated.setPassword(daopg.findByUsername(usr).getPassword());
		}
		
		String email = session.getAttribute("emailLogged").toString();
		updated.setEmail(email);
		updated.setUsername(username);
		updated.setDescrizione(descrizione);
		
		try {
			updated.setImmagine(image.isEmpty() ? daopg.findByPrimaryKey(email).getImmagine() : image.getBytes());
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		if ( daopg.update(updated) ) {
			//update username
			session.setAttribute("usernameLogged", username);
		}
		
		return "redirect:/account/" + username;
	}
	
	@DeleteMapping("/account/{username}/delete")
	@ResponseBody
	public String deleteAccount(HttpSession session, @PathVariable("username") String username) {
		if ( isNotLogged(username, session) ) {
			return "/";
		}
		ProfiloDAOPG daopg = new ProfiloDAOPG();
		daopg.delete(session.getAttribute("emailLogged").toString());
		return "/doLogout";
	}
	
	@PostMapping("/account/{username}/review/{id}/edit")
	public String editReview(@PathVariable("username") String usr, @PathVariable("id") int id, HttpSession session, @RequestParam String text, @RequestParam int stars) {
		if ( isNotLogged(usr, session) ) {
			return "redirect:/";
		}
		
		RecensioneDAOPG daopg = new RecensioneDAOPG();
		Recensione new_rec = new Recensione();
		new_rec.setId(id);
		new_rec.setTesto(text == null || text.equals("") ? null : text);
		new_rec.setValutazione(stars);
		daopg.update(new_rec);
		return "redirect:/account/" + usr;
	}
	
	@DeleteMapping("/account/{username}/review/{id}/delete")
	@ResponseBody
	public String deleteReview(HttpSession session, @PathVariable("username") String username, @PathVariable("id") int id) {
		if ( isNotLogged(username, session) ) {
			return "/";
		}
		RecensioneDAOPG daopg = new RecensioneDAOPG();
		Recensione del = new Recensione();
		del.setId(id);
		daopg.delete(del);
		return "/account/" + username;
	}
	
	@GetMapping("/deleteElement")
	public String deleteItem(HttpSession session, Model model, @RequestParam String idGame) {

		if ( isNotLogged(session.getAttribute("usernameLogged").toString(), session) ) {
			return "/";
		}

		ListaGiochiDAOPG listaGiochiDAOPG = new ListaGiochiDAOPG();
		boolean state = listaGiochiDAOPG.delete(session.getAttribute("emailLogged").toString(), idGame);

		if ( state ) {
			model.addAttribute("stateOperation", state);
		}
		return "redirect:/account/" + session.getAttribute("usernameLogged").toString();
	}
}
