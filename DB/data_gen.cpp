#include <iostream>
#include <random>
#include <cstdio>
#include <list>
#include <set>
#include <cstring>
using namespace std;

string insertProfilo(string email="", string password="", string username="");
string insertRecensione(int valutazione=0, string text="", int game=0, string email="");
string insertListaGiochi(string email="", int game=0);

void print(FILE* f, set<string>& s);

class generator {
private:
	random_device rd;
public:
	generator(){}
	generator(const generator&);
	~generator(){}
	int 	num(int m){
		int r =rd()%m; 
		return r>=0 ? r : r+m;}
	int 	num(int n, int m){
		int b = num(m);
		return b>=n ? b: m-n+b;}
	int 	game() {
		int r =rd()%100000; 
		return r>=0 ? r : r+100000;}
	string 	email() {return word(10)+'@'+word(5)+'.'+word(3);}
	string 	username() {return word(6,10);}
	string 	password() {return word(5);}
	string 	text() {
		string text = word(50, 255);
		int m=text.length()/5;
		for (int i = 0; i < m; ++i){
			text.insert(num(3,text.length()), " ");
		}
		return text.length()<=255 ? text: text.substr(0, 254);}
protected:
	string word(int n){
		string w;
		for (int i = 0; i < n; ++i){
			w+=(num(26)+'a');
		}
		return w;}
	string word(int n, int m){
		int q = num(n, m);
		return word(q);}
};

struct user
{
	string email;
	string username;
	string password;
};

user newUser(generator&);

int main(){
	vector<int> games;
	vector<user> users;

	set<string> un1;
	set<string> un2;
	set<string> un3;
	
	generator g;
	
	int n_u = 50, n_g = 100;
	int r_g=15, g_l=15;
		
	for (int i = 0; i < n_u; ++i)
		users.push_back(newUser(g));
	
	for (int i = 0; i < n_g; ++i)
		games.push_back(g.game());

	string s1 = ("INSERT INTO profilo (email, password, username) values\n");
	string s2 = ("INSERT INTO recensione (valutazione, testo, idgioco, scrittada) values\n");
	string s3 = ("INSERT INTO listagiochi (emailutente, idgioco) values\n");

	for (int i = 0; i < users.size(); ++i)
		un1.insert(insertProfilo(users.at(i).email, users.at(i).password, users.at(i).username));

	for (auto a = games.begin(); a != games.end(); ++a){
		int n = g.num(r_g,n_u);
		for (int i = 0; i < n; ++i)
			un2.insert(insertRecensione(g.num(5)+1, g.text(), games.at(g.num(n_g)), users.at(g.num(n_u)).email));
	}

	for (auto a = users.begin(); a != users.end(); ++a){
		int n = g.num(g_l, n_g);
		for (int i = 0; i < n; ++i)
			un3.insert(insertListaGiochi(a->email, games.at(g.num(n_g))));
	}

	FILE *p, *r, *l;
	p = fopen("profili.txt", "w");
	r = fopen("recensioni.txt", "w");
	l = fopen("liste.txt", "w");

	fputs(s1.c_str(), p);
	print(p, un1);

	fputs(s2.c_str(), r);
	print(r, un2);

	fputs(s3.c_str(), l);
	print(l, un3);

	return 0;
}

user newUser(generator& g){
	user u;
	u.email = g.email();
	u.password = g.password();
	u.username = g.username();
	return u;}

string insertProfilo(string email, string password, string username){
	return "('"+email+"','"+password+"','"+username+"'),\n";
}
string insertRecensione(int valutazione, string text, int game, string email){
	return "("+to_string(valutazione)+",'"+text+"',"+to_string(game)+",'"+email+"'),\n";
}
string insertListaGiochi(string email, int game){
	return "('"+email+"',"+to_string(game)+"),\n";
}

void print(FILE* handle, set<string>& lines){
	string last = *prev(lines.end());
	last.replace(last.find_last_of(','),1,";");
	lines.erase(prev(lines.end()));
	for (auto i = lines.begin(); i != lines.end(); ++i)
		fputs(i->c_str(), handle);
	fputs(last.c_str(), handle);
	fclose(handle);
}
