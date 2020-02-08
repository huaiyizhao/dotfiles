#!/bin/bash

cd ~/

for file in dotfiles/*; do
	if [[ $file != "dotfiles/install.sh" ]]; then 
		echo "$file"
		link="."$(echo "$file" | cut -d / -f 2)
		echo "$link"
		ln -s "$file" "$link" 
	fi
done

