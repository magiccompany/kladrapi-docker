<?php
/**

Phalcon v1.x.x support

**/
namespace Kladr\Frontend {

    class Module implements \Phalcon\Mvc\ModuleDefinitionInterface
    {

        /**
         * Регистрация автозагрузчика модуля
         */
        public function registerAutoloaders()
        {
            $config = new \Phalcon\Config\Adapter\Ini(__DIR__ . '/config/config.ini');
            $loader = new \Phalcon\Loader();

            $loader->registerNamespaces(
                    array(
                        'Kladr\Frontend\Models' => $config->application->modelsDir,
                        'Kladr\Frontend\Views' => $config->application->viewsDir,
                        'Kladr\Frontend\Controllers' => $config->application->controllersDir
                    )
            );

            $loader->register();
        }

        /**
         * Регистрация сервисов модуля
         */
        public function registerServices($di)
        {
            // Setting up dispatcher
            $di->set('dispatcher', function() use ($di) {

                $evManager = $di->getShared('eventsManager');
                $evManager->attach(
                    "dispatch:beforeException",
                    function($event, $dispatcher, $exception)
                    {
                        switch ($exception->getCode()) {
                            case \Phalcon\Mvc\Dispatcher::EXCEPTION_HANDLER_NOT_FOUND:
                            case \Phalcon\Mvc\Dispatcher::EXCEPTION_ACTION_NOT_FOUND:
                                $dispatcher->forward(
                                    array(
                                        'controller' => 'index',
                                        'action'     => 'show404',
                                    )
                                );
                                return false;
                        }
                    }
                );

                $dispatcher = new \Phalcon\Mvc\Dispatcher();
                $dispatcher->setDefaultNamespace("Kladr\Frontend\Controllers");
                $dispatcher->setEventsManager($evManager);
                return $dispatcher;
            });

            // Setting up the view component
            $di->set('view', function() {
                $view = new \Phalcon\Mvc\View();
                $view->setViewsDir('../apps/frontend/views/');
                return $view;
            });
        }

    }

}