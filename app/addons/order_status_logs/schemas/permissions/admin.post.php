<?php

if (!defined('BOOTSTRAP')) { die('Access denied'); }

$schema['order_status_logs']['permissions'] = array('GET' => 'view_order_status_logs', 'POST' => 'manage_order_status_logs');

return $schema;
