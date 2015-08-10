# User Agent Decoder

User Agent Decoder is simple Ruby Gem for parsing Browser's User Agent Strings. 

## Why?
There are already many user agent parser gems available, but due to the constant release of new browsers and operating systems, these libraries very quickly become obsolete.

With this in mind User Agent Decoder was build from the ground up to be easy to update, and for anyone to contribute to.

**Note:** The rules file is still a bit of a mess, and definitely be changed (and probably separated into multiple files) before being locked for version 1.0.

## Tested to destruction
User Agent Decoder has been tested against over 4,600 unique user agent strings, taken from BugMuncher's constantly growing database. Whenever an unrecognised user agent is found, this gem will be updated to understand it.

User Agent Decoder can currently parse user agent strings from the following Operating Systems:

 - Amazon Fire OS
 - Android
 - Apple iOS
 - Apple OS X
 - BlackBerry
 - BlackBerry PlayBook
 - Chrome OS
 - Java ME
 - MeeGo
 - Microsoft Windows
 - Microsoft Windows Phone
 - Nintendo Wii
 - Nokia Symbian
 - Red Hat Linux
 - Ubuntu Linux
 - Other Linux
 - Samsung Bada
 - Sony Playstation 3
 - WebOS

And the following browsers:

 - Adobe Dreamweaver
 - BlackBerry Browser
 - Dolfin
 - Firefox
 - Flock
 - Konqueror
 - Google Chrome
 - Internet Explorer
 - Microsoft Edge
 - Mercury
 - Nokia Browser
 - Opera
 - Opera Mini
 - Playstation 3 Browser
 - Safari
 - Safari Mobile
 - Samsung Smart TV
 - Silk
 - UC Browser
 - WebOS Browser

## Usage

    require 'user_agent_decoder'

    # Load an instance of User Agent Decoder
    user_agent_string = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.153 Safari/537.36"

    decoder = UserAgentDecoder.new  user_agent_string

    # Parse user agent and extract data
    result = decoder.parse

    puts result[:os][:name]            # 'Apple OS X'
    puts result[:os][:version]         # '10.8.5'
    puts result[:os][:version_name]    # 'Mountain Lion'
    puts result[:browser][:name]       # 'Google Chrome'
    puts result[:browser][:version]    # '35.0.1916.153'

## Version History
### v 0.0.1
First build, tested on small sample of user agents

### v 0.0.2
Alpha release, tested and working on over 4,500 user agents

### v 0.0.3
Improve browser and OS names

### v 0.0.4
Add support for OS X Yosemite

### v 0.0.5
Add suport for Windows 10 and Microsoft Edge browser