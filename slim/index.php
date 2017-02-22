<?php
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

require 'vendor/autoload.php';

$app = new \Slim\App;

// Get container
$container = $app->getContainer();

// Register component on container
$container['view'] = function ($container) {
	return new \Slim\Views\PhpRenderer('templates/');
};

$app->get('/', function (Request $request, Response $response) {
	$n = $request->getParam('n');
	return $this->view->render($response, 'hello.html', [
	    'result' => fib($n),
	]);
});

function fib($n) {
    [$a, $b] = [0, 1];
    for ($i=0; $i < $n; $i++) {
        [$a, $b] = [$b, $a + $b];
    }
    return $a;
    
}

$app->run();
