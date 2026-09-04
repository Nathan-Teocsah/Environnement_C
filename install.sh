ok=0
PATH_INSTALL="$(pwd)"
>"enligne.sh"
chmod +x enligne.sh
while read -r ligne
do
	if [ $ok = 1 ]
	then
		if [[ $ligne = "PATH_CENLIGNE=" ]]
		then
			texte="$ligne"
			texte+='"'$PATH_INSTALL'"'
			echo "$texte" >> "enligne.sh"
		else
			echo $ligne >> "enligne.sh"
		fi
	fi

	if [[ $ok = 0 && $ligne = "#=== CODE SOURCE ===" ]]
	then
		ok=1
	fi
done <install.sh

cd 
echo "alias compc="$PATH_INSTALL"" >> ".bashrc"  
source .bashrc

exit 1
#=== CODE SOURCE ===
# ATTENTION : si un commentaire contient une accolade cela va faire planter le programme !!

PATH_CENLIGNE=
COMPIL="gcc"
Temp=$PATH_CENLIGNE
Temp+=temp.c
copy_Temp=$PATH_CENLIGNE
copy_Temp+=copy_temp.c
echo "#include <stdio.h>" >$Temp
echo "int main(int argc, char const *argv[]){" >>$Temp
echo "}" >>$Temp
echo "---------- Environnement en ligne C ----------"
opt=()
texte=()
compte_glob1=0
compte_glob2=0
set -f
while true
do
	LIGNES=()
	while read ligne
	do
		LIGNES+=("$ligne")
	done <$Temp
	
	read -r -p "> " commande
	compte_global1=$((compte_global1 + $(echo "$commande" | sed -e 's/\(.\)/\1\n/g' | grep -F { | wc -l)))
	compte_global2=$((compte_global2 + $(echo "$commande" | sed -e 's/\(.\)/\1\n/g' | grep -F } | wc -l)))
	
	if [[ "$commande" = ".save" ]]
	then
		read -r -p "Où enregistrer ? " path_to_file
		if [ "$path_to_file" = "nul part" ]
		then
			path_to_file="$PATH_CENLIGNE/save"
		else
			path_to_file+="/"
			read -r -p "Nom de la sauvegarde : " name_of_file
			path_to_file+=$name_of_file
		fi
		>$path_to_file
		for ligne_texte in "${LIGNES[@]}"
		do
			echo $ligne_texte >>$path_to_file
		done
		echo "--> Energistrement terminé !"
		continue
	fi
	
	if [[ "$commande" = ".load" ]]
	then
		read -r -p "Où est le fichier ? " path_to_file
		if [[ "$path_to_file" = "nul part" ]]
		then
			path_to_file="$PATH_CENLIGNE/save"
		else
			path_to_file+="/"
			read -r -p "Nom de la sauvegarde : " name_of_file
			path_to_file+=$name_of_file
		fi
		if [ -f "$path_to_file" ]
		then
			texte=()
			opt=()
			nb=0
			>$Temp
			echo ""
			echo "--> Chargement..."
			while read ligne
			do
				compte_global1=$((compte_global1 + $(echo "$ligne" | sed -e 's/\(.\)/\1\n/g' | grep -F { | wc -l)))
				compte_global2=$((compte_global2 + $(echo "$ligne" | sed -e 's/\(.\)/\1\n/g' | grep -F } | wc -l)))
				
				if [[ $compte_global1 > 0 ]]
				then 
					nb=$(($nb+1))
				fi

				if [[ $compte_global1 > 0 && $compte_global2 < $compte_global1 && $nb > 1 ]]
				then
					echo "> "$ligne
				fi
				echo $ligne >> $Temp
				
			done <$path_to_file
			compte_global1=$((compte_global1-1))
			compte_global2=$((compte_global2-1))
			echo "--> Chargement Terminé !"
			echo ""
		else
			echo "--> Le fichier '$name_of_file' n'existe pas."
		fi
		continue
	fi

	if [[ "$commande" = ".sup" ]]
	then
		dernier_indice=$(( ${#LIGNES[@]} - 2 ))        
		derniere_commande=${LIGNES[$dernier_indice]}     
		unset LIGNES[$dernier_indice]                   
		>$Temp
		for ligne_texte in "${LIGNES[@]}"
		do
			echo $ligne_texte >>$Temp
		done
		echo "--> Ligne supprimée : $derniere_commande"
		continue
	fi
	
	if [[ "$commande" = ".exe" ]]
	then
		echo ""
		echo "--> Execution..."
		$PATH_CENLIGNE/a.out
		echo "--> Executé !"
		echo ""
		continue
	fi
	
	if [[ "$commande" != "link: "* ]]
	then
		if [ "$commande" = ".r" ]
		then
			echo "#include <stdio.h>" >$Temp
			echo "int main(int argc, char const *argv[]){" >>$Temp
			echo "}" >>$Temp
			echo "---> RESET"
			continue
		fi
		
		if [[ "$commande" = "#include"* ]]
		then 
			if [[ "${texte[@]}" != "" ]]; then
				echo "---> commande non valide : il faut d'abord terminer la ligne précédente."
				continue
			fi
			echo "$commande" > $copy_Temp
			while read ligne
			do
				echo $ligne >> $copy_Temp
			done <$Temp
			
			texte=()
			$COMPIL $copy_Temp -o $PATH_CENLIGNE/a.out "${opt[@]}"
			if [ $? -eq 0 ]; then
				echo ""
				echo "--> Execution..."
				>$Temp
				while read ligne
				do
					echo "$ligne" >>$Temp
				done <$copy_Temp
				$PATH_CENLIGNE/a.out
				echo "--> Exécuté !"
				echo ""
			fi
		fi
		
		if [[ ( "$commande" == *";" && $compte_global1 = $compte_global2 ) || ( $compte_global1 = $compte_global2 && $compte_global1 != 0 ) ]]
		then
			>$copy_Temp
			compte1=0
			compte2=0
			while read ligne
			do
				compte1=$((compte1 + $(echo "$ligne" | sed -e 's/\(.\)/\1\n/g' | grep -F { | wc -l)))
				compte2=$((compte2+$(echo "$ligne" | sed -e 's/\(.\)/\1\n/g' | grep -F } | wc -l)))
				if [[ $compte1 = $compte2 && $compte1 > 0 ]]
				then
					for ligne_texte in "${texte[@]}"
					do
						echo $ligne_texte >>$copy_Temp
					done
					echo $commande >>$copy_Temp
					echo "}" >>$copy_Temp
				else
					echo "$ligne" >>$copy_Temp
				fi
			done <$Temp
			
			texte=()
			$COMPIL $copy_Temp -o $PATH_CENLIGNE/a.out "${opt[@]}"
			
			if [ $? -eq 0 ]; then
				echo ""
				echo "--> Execution..."
				$PATH_CENLIGNE/a.out
				echo ""
				aout_exit_code=$?
				
				if [ $aout_exit_code -eq 0 ]
				then
					>$Temp
					while read ligne
					do
						echo "$ligne" >>$Temp
					done <$copy_Temp
					echo "--> Exécuté !"
				else
					echo "--> Exécuté ! (Non enregistré)"
				fi
				echo ""
			fi
		else
			texte+=("$commande")
		fi
	else
		read -r prompt lib <<< "$commande"
		$COMPIL$Temp "${opt[@]}" "$lib"

		if [ $? -eq 0 ]; then
			opt+=("$lib")
		fi
	fi		
done
	
