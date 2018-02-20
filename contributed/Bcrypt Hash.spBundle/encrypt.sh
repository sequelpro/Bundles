#!/usr/bin/php
<?php
    $input = trim(fgets(STDIN));
    print password_hash($input, PASSWORD_BCRYPT);
?>
