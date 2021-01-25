package Model;

public class Recensione {
	private Integer id;
	private Integer valutazione;
	private String testo;
	private String idGioco;
	private String scrittaDa;
	
	public Integer getId() {
		return id;
	}
	
	public void setId(Integer id) {
		this.id = id;
	}
	
	public Integer getValutazione() {
		return valutazione;
	}
	
	public void setValutazione(Integer valutazione) {
		this.valutazione = valutazione;
	}
	
	public String getTesto() {
		return testo;
	}
	
	public void setTesto(String testo) {
		this.testo = testo;
	}
	
	public String getIdGioco() {
		return idGioco;
	}
	
	public void setIdGioco(String idGioco) {
		this.idGioco = idGioco;
	}
	
	public String getScrittaDa() {
		return scrittaDa;
	}
	
	public void setScrittoDa(String scrittaDa) {
		this.scrittaDa = scrittaDa;
	}
	
	@Override
	public String toString() {
		return "Recensione{" + "id=" + id + ", valutazione=" + valutazione + ", testo" + "='" + testo + '\'' + ", idGioco='" + idGioco + '\'' + ", " + "scrittaDa='" + scrittaDa + '\'' + "}<br>";
	}
}
