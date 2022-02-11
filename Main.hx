package;

enum abstract Asteguna(Int) from Int to Int {
	var igandea;
	var astelehena;
	var asteartea;
	var asteazkena;
	var osteguna;
	var ostirala;
	var larunbata;
}

class Main {
	static function main() {
		var asteguna = Date.now().getDay();

		var arrazoia = switch asteguna {
			case astelehena:
				'astelehena,\njai ondoko alperra,\nlanik ez egiteko';
			case asteartea:
				'asteartea,\neuria goitik behera,\nbustiko ez bagara,';
			case asteazkena:
				'asteazkena,\nosabaren ezkontza,\nberak nahi baldin badu,';
			case osteguna:
				'osteguna,\namonaren eguna,\nhori ospatutzeko,';
			case ostirala:
				'ostirala,\nhaginetako mina,\naspirina hartuta,\nbagoaz ohera,';
			case larunbata:
				'larunbata,\negun erdiko lana,\negun erditxogatik,';
			case igandea:
				'igandea,\nlantegiak itxita,\nlana egin nahi baina,';
			case x:
				'$x. eguna,\nez dago_horrelakorik,\nexistitzen ez bada,';
		}

		for (_ in 0...5)
			arrazoia += '\nez goaz lanera';

		var content = sys.io.File.getContent('readme.tpl.md');
		content = StringTools.replace(content, "::arrazoia::", StringTools.replace(arrazoia, '\n', '\\\n'));
		sys.io.File.saveContent('readme.md', content);

		#if mastobot_token
		var endpoint = 'https://botsin.space/api/v1/statuses';
		var mastobot_token = haxe.macro.Context.definedValue('mastobot_token');

		var http = new sys.Http(endpoint);
		http.addHeader('Authorization', 'Bearer ' + mastobot_token);
		http.addHeader("Content-type", "application/json");

		http.setPostData(haxe.Json.stringify({
			status: arrazoia
		}));

		http.onError = (e) -> trace('errorea: $e');

		http.request(true);

		trace(http.responseData);
		#end
	}
}
