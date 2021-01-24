package group64.gamesyllabus.controller;

import Model.Profilo;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Base64Utils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import persistence.DAO.JDBC.ProfiloDAOPG;

import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
public class AccountController {
	
	@GetMapping(path = "/account/{username}")
	public String getAccount(@PathVariable("username") String username, Model model, HttpSession session) {
		if ( isNotLogged(username, session) ) {
			return "redirect:/";
		}
		
		ProfiloDAOPG daopg = new ProfiloDAOPG();
		Profilo profilo = daopg.findByUsername(username);
		
		model.addAttribute("password", profilo.getPassword());
		model.addAttribute("username", profilo.getUsername());
		String descrizione = profilo.getDescrizione();
		model.addAttribute("descrizione", descrizione == null || descrizione.equals("") ? null : descrizione);
		
		if ( profilo.getImmagine() != null ) {
			model.addAttribute("immagine", "data:image/*;base64," + Base64Utils.encodeToString(profilo.getImmagine()));
		}
		
		return "profile";
	}
	
	private boolean isNotLogged(String username, HttpSession session) {
		return session.getAttribute("usernameLogged") == null || !session.getAttribute("usernameLogged").toString().equals(username);
	}
	
	@PostMapping("/account/edit")
	public String editAccount(HttpSession session, @RequestParam String password, @RequestParam String new_password, @RequestParam String username, @RequestParam String descrizione, @RequestParam MultipartFile image, Model model) {
		ProfiloDAOPG daopg = new ProfiloDAOPG();
		String usr = session.getAttribute("usernameLogged").toString();
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
			}
		} else {
			//no password to confirm
			model.addAttribute("error", true);
			model.addAttribute("error_message", "Please, insert your password to confirm");
			return "redirect:/account/" + usr;
		}
		
		Profilo updated = new Profilo();
		String email = session.getAttribute("emailLogged").toString();
		
		updated.setEmail(email);
		updated.setPassword(BCrypt.hashpw(password, BCrypt.gensalt(12)));
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
	
	@DeleteMapping("/account/delete")
	@ResponseBody
	public String delete(HttpSession session, @RequestHeader String username) {
		if ( isNotLogged(username, session) ) {
			return "/";
		}
		ProfiloDAOPG daopg = new ProfiloDAOPG();
		daopg.delete(session.getAttribute("emailLogged").toString());
		return "/doLogout";
	}
}
