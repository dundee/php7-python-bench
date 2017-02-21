<?php

namespace App\Presenters;

use Nette;


class HomepagePresenter extends Nette\Application\UI\Presenter
{
	public function renderDefault() {
		$n = $this->request->getParameter('n');
		$this->template->result = fib($n);
	}
}

function fib($n) {
	if ($n < 2) {
		return $n;
	}
	return fib($n - 1) + fib($n - 2);
}
