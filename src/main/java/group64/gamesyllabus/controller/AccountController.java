package group64.gamesyllabus.controller;

import Model.Profilo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Base64Utils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import persistence.DAO.JDBC.ProfiloDAOPG;

import java.io.IOException;

@Controller
public class AccountController {
	@GetMapping("/accounts/all")
	@ResponseBody
	public String getAll() {
		ProfiloDAOPG daopg = new ProfiloDAOPG();
		return daopg.findAll().toString();
	}
	
	@GetMapping(path = "/account/{username}")
	public String getAccount(@PathVariable("username") String username, Model model) {
		ProfiloDAOPG daopg = new ProfiloDAOPG();
		Profilo profilo = daopg.findByUsername(username);
		model.addAttribute("email", profilo.getEmail());
		model.addAttribute("password", profilo.getPassword());
		model.addAttribute("username", profilo.getUsername());
		model.addAttribute("descrizione", profilo.getDescrizione());
		if ( profilo.getImmagine() != null ) {
			model.addAttribute("immagine", "data:image/*;base64," + Base64Utils.encodeToString(profilo.getImmagine()));
		}
		return "profile";
	}
	
	@PostMapping("/account/edit")
	public String editAccount(@RequestParam String email, @RequestParam String password, @RequestParam String username, @RequestParam String descrizione, @RequestParam MultipartFile image) {
		Profilo updated = new Profilo();
		updated.setEmail(email);
		updated.setPassword(password);
		updated.setUsername(username);
		updated.setDescrizione(descrizione);
		try {
			updated.setImmagine(image.getBytes());
		} catch (IOException e) {
			e.printStackTrace();
		}
		ProfiloDAOPG daopg = new ProfiloDAOPG();
		return "redirect:/account/" + username;
	}
	
	@GetMapping("/account/delete")
	public String delete() {
		return "redirect:index";
	}
}
