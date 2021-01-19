package group64.gamesyllabus.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@org.springframework.stereotype.Controller

public class GenreController {
     @GetMapping("/genre")
        public String genreChoose(@RequestParam String genreName, Model model ){
        model.addAttribute("genre", genreName);
         return "genre";
        }

    @GetMapping("/genres")
    public String genresList(){
        return "genresList";
    }
    }
