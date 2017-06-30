#!/bin/bash
# Author: Alexander Epstein https://github.com/alexanderepstein

currentVersion="1.4.0" #This version variable should not have a v but should contain all other characters ex Github release tag is v1.2.4 currentVersion is 1.2.4
locale=$(echo $LANG | cut -c1-2)
configuredClient=""

## This function determines which http get tool the system has installed and returns an error if there isnt one
getConfiguredClient()
{
    if  command -v curl &>/dev/null ; then
      configuredClient="curl"
    elif command -v wget &>/dev/null ; then
      configuredClient="wget"
    elif command -v fetch &>/dev/null ; then
      configuredClient="fetch"
    else
      echo "Error: This tool reqires either curl, wget, or fetch to be installed."
      return 1
    fi

}

## Allows to call the users configured client without if statements everywhere
httpGet()
{
  case "$configuredClient" in
    curl) curl -A curl -s "$@";;
    wget) wget -qO- "$@";;
    fetch) fetch -o "...";;
  esac
}


getIPWeather()
{
  country=$(httpGet ipinfo.io/country) > /dev/null ## grab the country
  if [[ $country == "US" ]];then ## if were in the us id rather not use longitude and latitude so the output is nicer
    city=$(httpGet ipinfo.io/city) > /dev/null
    region=$(httpGet ipinfo.io/region) > /dev/null
    region=$(echo "$region" | tr -dc '[:upper:]')
    httpGet $locale.wttr.in/$city,$region$1
  else ## otherwise we are going to use longitude and latitude
    location=$(httpGet ipinfo.io/loc) > /dev/null
    httpGet $locale.wttr.in/$location$1
  fi
}

getLocationWeather()
{
  httpGet $locale.wttr.in/$1+$2+$3+$4
}

#checkInternet()
#{
 # echo "GET http://google.com HTTP/1.0\n\n" | nc google.com 80 > /dev/null 2>&1 # query google with a get request
 # if [ $? -eq 0 ]; then #check if the output is 0, if so no errors have occured and we have connected to google successfully
 #   return 0
 # else
 #   echo "Error: no active internet connection" >&2 #sent to stderr
 #   return 1
 # fi
#}

update()
{
  # Author: Alexander Epstein https://github.com/alexanderepstein
  # Update utility version 1.2.0
  # To test the tool enter in the defualt values that are in the examples for each variable
  repositoryName="Bash-Snippets" #Name of repostiory to be updated ex. Sandman-Lite
  githubUserName="alexanderepstein" #username that hosts the repostiory ex. alexanderepstein
  nameOfInstallFile="install.sh" # change this if the installer file has a different name be sure to include file extension if there is one
  latestVersion=$(httpGet https://api.github.com/repos/$githubUserName/$repositoryName/tags | grep -Eo '"name":.*?[^\\]",'| head -1 | grep -Eo "[0-9.]+" ) #always grabs the tag without the v option

  if [[ $currentVersion == "" || $repositoryName == "" || $githubUserName == "" || $nameOfInstallFile == "" ]];then
    echo "Error: update utility has not been configured correctly." >&2
    exit 1
  elif [[ $latestVersion == "" ]];then
    echo "Error: no active internet connection" >&2
    exit 1
  else
    if [[ "$latestVersion" != "$currentVersion" ]]; then
      echo "Version $latestVersion available"
      echo -n "Do you wish to update $repositoryName [Y/n]: "
      read -r answer
      if [[ "$answer" == "Y" || "$answer" == "y" ]] ;then
        cd  ~ || { echo 'Update Failed' ; exit 1 ; }
        if [[ -d  ~/$repositoryName ]]; then rm -r -f $repositoryName  ||  { echo "Permissions Error: try running the update as sudo"; exit 1; } ; fi
        git clone "https://github.com/$githubUserName/$repositoryName" || { echo "Couldn't download latest version" ; exit 1; }
        cd $repositoryName ||  { echo 'Update Failed' ; exit 1 ;}
        git checkout "v$latestVersion" 2> /dev/null || git checkout "$latestVersion" 2> /dev/null || echo "Couldn't git checkout to stable release, updating to latest commit."
        chmod a+x install.sh #this might be necessary in your case but wasnt in mine.
        ./$nameOfInstallFile "update" || exit 1
        cd ..
        rm -r -f $repositoryName ||  { echo "Permissions Error: update succesfull but cannot delete temp files located at ~/$repositoryName delete this directory with sudo"; exit 1; }
      else
        exit 1
      fi
    else
      echo "$repositoryName is already the latest version"
    fi
  fi

}

usage()
{
  echo "Weather tool"
  echo "Usage: weather or weather [flag] or weather [country] or weather [city] [state]"
  echo "  weather [i] get weather in imperial units"
  echo "  weather [m] get weather in metric units"
  echo "  weather [Moon] grabs the phase of the moon"
  echo "  -u Update Bash-Snippet Tools"
  echo "  -h Show the help"
  echo "  -v Get the tool version"
}

getConfiguredClient || exit 1
#checkInternet || exit 1 # check if we have a valid internet connection if this isnt true the rest of the script will not work so stop here




while getopts "uvh" opt; do
  case $opt in
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
    ;;
    h)
      usage
      exit 0
    ;;
    v)
      echo "Version $currentVersion"
      exit 0
    ;;
    u)
      update
      exit 0
    ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
    ;;
  esac
done

if [[ $# == "0" ]]; then
  getIPWeather
elif [[ $1 == "help" ]];then
  usage
elif [[ $1 == "update" ]]; then
  update
elif [[ $1 == "m" ]]; then
  getIPWeather "?m"
elif [[ $1 == "i" ]]; then
  getIPWeather "?u"
else
  getLocationWeather $1 $2 $3 $4
fi
