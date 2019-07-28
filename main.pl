use v5.10;
use strict;
use warnings;
use experimental 'smartmatch';
use LWP::UserAgent qw(new);
use Term::ANSIColor qw(color colored);
use WWW::UserAgent::Random qw(rand_ua);

my $VERSION='1.0.2';

my $type;
my $level='any';
my $output_file_path='proxies.txt';

sub get_arg{
	my $arg=shift @ARGV;
	if(!$arg||$arg=~/^-{1,2}/){die colored "[-] Wrong number of arguments for \"$_\".\nExpected $_[1].\nGot ".($_[0]-1).".\n",'red'}
	if($_[2]){
		if(not $arg~~$_[3]){
			die colored "[-] Invalid $_[2] \"$arg\".\nSupported $_[2]s: ".join(' ',@{$_[3]})."\n",'red'
		}
	}
	return $arg;
}
do{
	given(shift @ARGV){
		when(['-v','--version']){
			print "Proxy-Scraper v$VERSION\n";
			exit;
		}
		when(['-t','--type']){$type=get_arg(1,1,'proxy type',['http','https','socks4','socks5'])}
		when(['-l','--level']){$level=get_arg(1,1,'proxy anonymity level',['transparent','anonymous','elite'])}
		when(['-o','--output']){$output_file_path=get_arg(1,1)}
		default{
			print color 'blue';
			print "usage: perl main.pl [-h] [-v] -t {http,https,socks4,socks5} [-l {transparent,anonymous,elite}] [-o PATH] \n";
			print "  -h, --help            show help message and exit\n";
			print "  -v, --version            show version and exit\n";
			print "  -t, --type {http,https,socks4,socks5}\n            set type of proxy\n";
			print "  -l, --level {transparent,anonymous,elite}\n            set level of proxy anonymity\n";
			print "  -o, --output PATH\n            set path to output file\n";
			if(not $_~~[undef,'-h','--help']){die colored "[-] Invalid option \"$_\".\n",'red'}
			print color 'reset';
			exit;
		}
	}
}while(@ARGV);
die colored "[-] \"-t\"/\"--type\" option is required.\n",'red' if(!$type);

print colored "[+] Opening \"$output_file_path\"\n",'green';
open my $output_file,'>',$output_file_path or die colored "[-] Can't open \"$output_file_path\": $!.\n",'red';
print colored "[+] Successfully opened \"$output_file_path\"\n",'green';
my $agent=LWP::UserAgent->new(
	agent=>rand_ua 'browsers',
);
my $proxies_scraped_total=0;
sub scrape_free_socks{
	if($level eq 'any'){
		my $local_type=$type=~/socks./ ?'socks5':'https';
		my $link='https://free-socks.in/'.($type=~/socks./ ?'socks':'http').'-proxy-list/';
		print colored "[+] Scraping $level $local_type proxies from \"$link\"\n",'green';
		my $response=$agent->get($link);
		if($response->is_success){
			my $proxies_scraped=0;
			foreach($response->decoded_content=~/<td>((?:\d+\.){3}\d+:\d+)<\/td>/g){
				print $output_file "$_\n";
				$proxies_scraped++;
			}
			$proxies_scraped_total+=$proxies_scraped;
			print colored "[+] Successfully scraped $proxies_scraped $level $local_type proxies from \"$link\"\n",'green';
		}else{warn colored '[-] Server returned '.$response->code.".\n",'red'}
	}
}
sub scrape_free_proxy_list{
	my @types;
	given($type){
		when('http'){@types=('http','https')}
		when('https'){@types=('https')}
		when('socks4'){@types=('socks4','socks5')}
		when('socks5'){@types=('socks5')}
	}
	my $response;
	my @levels=$level eq 'any'?('transparent','anonymous','elite'):($level);
	foreach my $current_type (@types){
		foreach my $current_level (@levels){
			print colored "[+] Scraping $current_level $current_type proxies from \"https://www.proxy-list.download/api/v1/get?type=$current_type&anon=$current_level\"\n",'green';
			$response=$agent->get("https://www.proxy-list.download/api/v1/get?type=$current_type&anon=$current_level");
			if($response->is_success){
				print $output_file $response->decoded_content;
				my $proxies_scraped=$response->decoded_content=~tr/\n//;
				$proxies_scraped_total+=$proxies_scraped;
				print colored "[+] Successfully scraped $proxies_scraped $current_level $current_type proxies from \"https://www.proxy-list.download/api/v1/get?type=$current_type&anon=$current_level\"\n",'green';
			}else{warn colored '[-] Server returned '.$response->code.".\n",'red'}
		}
	}
}
sub scrape_openproxy_space{
	if(($type eq 'socks4' and $level~~['any','elite']) or ($type eq 'http' and $level eq 'any')){
		print colored "[+] Scraping proxies lists from \"https://openproxy.space/lists/\"\n",'green';
		my $response=$agent->get('https://openproxy.space/lists/');
		if($response->is_success){
			foreach($response->decoded_content=~/href="\/lists\/([\w_-]+)" rel="nofollow" class="list http"/g){
				print colored "[+] Scraping proxies from \"https://openproxy.space/lists/$_\"\n",'green';
				my $response2=$agent->get("https://openproxy.space/lists/$_");
				if($response2->is_success){
					my $proxies_scraped=0;
					foreach($response2->decoded_content=~/((?:\d+\.){3}\d+:\d+)/g){
						print $output_file "$_\n";
						$proxies_scraped++;
					}
					$proxies_scraped_total+=$proxies_scraped;
					print colored "[+] Successfully scraped $proxies_scraped $level $type proxies from \"https://openproxy.space/lists/$_\"\n",'green';
				}else{warn colored '[-] Server returned '.$response2->code.".\n",'red'}
			}
		}else{warn colored '[-] Server returned '.$response->code.".\n",'red'}
	}
}
scrape_free_socks;
scrape_free_proxy_list;
scrape_openproxy_space;
print colored "[+] Successfully scraped $proxies_scraped_total proxies in total.\n",'green';
print colored "[+] Closing \"$output_file_path\"\n",'green';
close $output_file or die colored "[-] Can't close \"$output_file_path\": $!.\n",'red';
print colored "[+] Successfully closed \"$output_file_path\"\n",'green';
