<?php

require 'vendor/autoload.php';

use Symfony\Component\Yaml\Yaml;

$stdin = fopen('php://stdin', 'r');

while ($data = fgetcsv($stdin)) {
	if (empty($data[0])) {
		break;
	}
	$result[] = $data;
}

fclose($stdin);

$columns = array_shift($result);

foreach ($result as $row) {

    $yamlArr[] = array_combine($columns, $row);

}

print Yaml::dump($yamlArr);