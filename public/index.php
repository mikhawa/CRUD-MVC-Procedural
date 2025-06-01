<?php
# exemple5MVC/public/index.php

/*
 * Contrôleur frontal
 */

session_start();

// dépendances
require_once "../config-dev.php";

// notre connexion PDO

// ici nos contrôleurs

echo '<h4>session_id() ou SID</h4>';
var_dump(session_id());
echo '<h4>$_GET</h4>';
var_dump($_GET);
echo '<h4>$_SESSION</h4>';
var_dump($_SESSION);
echo '<h3>$_POST</h3>';
var_dump($_POST);


// bonne pratique
