package group64.gamesyllabus.controller;

import Model.Profilo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import persistence.DAO.JDBC.ProfiloDAOPG;

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
		model.addAttribute("email",profilo.getEmail());
		model.addAttribute("password",profilo.getPassword());
		model.addAttribute("username",profilo.getUsername());
		model.addAttribute("descrizione",profilo.getDescrizione());
		return "profile";
	}
	
	@PostMapping("/upload")
	public String upload(@RequestAttribute MultipartFile pic) {
		System.out.println("Name: " + pic.getName());
		System.out.println("Original File Name: " + pic.getOriginalFilename());
		System.out.println("Size: " + pic.getSize());
		System.out.println("Content Type: " + pic.getContentType());
		return "index";
	}
}
