<?php

if (!defined('BOOTSTRAP')) { die('Access denied'); }

use Tygh\Registry;

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if ($mode === 'clean') {
        fn_cleanup_order_status_logs();

        fn_set_notification('N', __('notice'), __('successful'));
    }

    return [CONTROLLER_STATUS_REDIRECT, 'order_status_logs.manage'];
}

if ($mode == 'manage') {

    list($logs, $search) = fn_get_orders_statuses_logs($_REQUEST, Registry::get('settings.Appearance.admin_elements_per_page'));
    $statuses_descr = fn_get_simple_statuses(STATUSES_ORDER, true, true);

    Tygh::$app['view']->assign(array(
        'logs' => $logs,
        'statuses_descr' => $statuses_descr,
        'search' => $search
    ));
}
