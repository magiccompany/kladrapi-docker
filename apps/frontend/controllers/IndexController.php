<?php

namespace Kladr\Frontend\Controllers {

    use \Phalcon\Tag,
        \Phalcon\Mvc\Controller;

    class IndexController extends Controller
    {

        public function initialize()
        {
            Tag::setTitle('Wha?');
        }

        public function indexAction()
        {
            //
        }

        public function show404Action()
        {
            $this->response->setStatusCode('404', 'Not found :(');
            echo "<h1>Not found :(</h1>";
        }

    }

}