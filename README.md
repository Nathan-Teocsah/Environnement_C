# C'est quoi ?

L'idée est de créer une invite de commande (comme il existe déjà pour python) permettant d'executer des commandes sans créer de fichier et de la compiler "à la main" :

# Installation
Il suffit de cloner le projet à l'aide de **git clone** puis de rendre exécutable _install.sh_ à l'aide de la commande :
>chmod +x install.sh<br>
puis d'éxécuter le programme.

# Comment ça fonctionne ?

Pour lancer le programme, il suffit d'ouvrir une invite de commande et de taper _compc_ , peu importe depuis quel répertoire on effectue la commande.
Il suffit d'écrire le code que l'on veut éxécuter dans l'invite de commande et d'appuyer sur entrée

>---------- Environnement en ligne C ----------<br>
>\> for (int i=0;i<5;i++){<br>
>\> printf("%d",i);<br>
>\> }<br>
>
>--> Execution...<br>
>01234<br>
>--> Exécuté !<br>
>
>\>

Le compilateur utilisé est gcc. Il est possible de modifier le compilateur utilisé en modifiant la valeur de la variable "_COMPIL_" dans le script _enligne.sh_.

# Code sur plusieurs lignes

Pour coder sur plusieurs ligne, il suffit soit d'ouvrir une accolade et de la fermer sur une ligne suivante :
>---------- Environnement en ligne C ----------<br>
>\> for (int i=0;i<5;i++){<br>
>\> printf("%d",i);<br>
>\> }<br>
>
>--> Execution...<br>
>01234<br>
>--> Exécuté !<br>
>
>\>

Une autre façon de faire est de tout simplement pas mettre de point virgule à la fin de la ligne, le programme va enregistrer la ligne, mais ne l'exécuter qu'à la première apparition d'un point virgule :
>---------- Environnement en ligne C ----------<br>
>\> int i,j,k;<br>
><br>
>--> Execution...<br>
><br>
>--> Exécuté !<br>
><br>
>\> printf("%d %d %d",<br>
>\> i,<br>
>\> j,<br>
>\> k);<br>
><br>
>--> Execution...<br>
>32764 -224317712 0<br>
>--> Exécuté !<br>
><br>
>\> 

# Supprimer une ligne

Pour supprimer une ligne précédement tapé il suffit de taper _.sup_

# Enregistrer la session en cours

Pour cela il suffit de taper _.save_ qui se présente de la manière suivante :
>---------- Environnement en ligne C ----------<br>
>\> .save<br>
>Où enregistrer ? 

après avoir préciser le dossier d'enregistrement (ce peut être le dossier courant en tapant usuellement un point "_._" on tape le nom du fichier :
>---------- Environnement en ligne C ----------<br>
>\> .save<br>
>Où enregistrer ? .<br>
>Nom de la sauvegarde : test<br>
>--> Energistrement terminé !

Si jamais, on ne veut pas enregistrer dans un fichier spécifique, il est possible d'enregistrer le projet dans le dossier où est stocké le script shell en tapant _nul part_ :
>---------- Environnement en ligne C ----------<br>
>\> .save<br>
>Où enregistrer ? nul part<br>
>--> Energistrement terminé !


# Charger un code déjà existant
Pour charger un code déjà existant il suffit de taper : _.load_
Le script va alors pour demander où se trouve le fichier puis son nom. Si l'on souhait charger un fichier enregisré après avoir tapé _nul part_ lors de la procédure d'enregisrement, il suffit de taper de nouveau _nul part_ lorsque le script demande l'emplacement du fichier :
>---------- Environnement en ligne C ----------<br>
>\> .load<br>
>Où est le fichier ? nul part<br>
>\><br>
>--> Chargement...<br>
>--> Chargement Terminé !<br>
>\><br>
>\>

# Executer de nouveau le code sans ajouter une nouvelle ligne

Pour réexécuter le code, il suffit de taper _.exe_ :
>---------- Environnement en ligne C ----------<br>
>\> int i;<br>
><br>
>--> Execution...<br>
><br>
>--> Exécuté !<br>
><br>
>\> printf("%d",i);<br>
><br>
>--> Execution...<br>
>32766<br>
>--> Exécuté !<br>
><br>
>\> .exe <br>
>\><br>
>--> Execution...<br>
>32766--> Executé !<br>
><br>
>\> <br>


# Comment rajouter une option au compilateur

Si l'on utilise la librairie math.h, il faut rajouter une option dans le compilateur, cela ce fait de la manière suivante :
Sur la même ligne on écrit : _link: [opt]_ par exemple : _> link: -lm_


# Comment rajouter un header ?

Il suffit simplement d'écrire ce qu'on écrirait dans un script en C :
>---------- Environnement en ligne C ----------<br>
>\> #include <stdlib.h><br>

Le header stdio.h est déjà écrit, il n'y a pas besoin de le rajouter.
