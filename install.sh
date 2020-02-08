#!/bin/bash

cd ~/

for file in dotfiles/*; do
	if [[ $file != "dotfiles/install.sh" ]]; then 
		link="."$(echo "$file" | cut -d / -f 2)
		echo "link $file to $link"
		ln -s "$file" "$link" 
	fi
done

