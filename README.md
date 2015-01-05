buzzwords
=========
Main purpose of this code is to crawl speeches from the Icleandic Parliament's (Althingi's) website, www.althingi.is. 

Code contains Ruby object MembersOfParliament, a list object containing several MemberOfParliament objects.

Each MemberOfParliament object represents a member of Althingi and has a name, detail and page attributes.
The page attribute is a Mechanize::Page object representing the page on www.althingi.is that contains that MP's 
speeches for a given year. 

Code is sure to change more often than this README so it's best to consult the source if in doubt.

Commands are added to the main.rb file as needed.

To run: $ruby main.rb from command line when in directory.
