<?php

defined('BOOTSTRAP') or die('Access denied');

function fn_order_status_logs_change_order_status_post($order_id, $status_to, $status_from, $force_notification, $place_order, $order_info, $edp_data)
{
    $user_id = Tygh::$app['session']['auth']['user_id'] ?? 0;
    $data = array(
        'order_id' => $order_id,
        'status_from' => $status_from,
        'status_to' => $status_to,
        'user_id' => $user_id,
        'timestamp' => TIME
    );

    db_query("INSERT INTO ?:order_status_logs ?e", $data);
}

function fn_get_orders_statuses_logs($params = array(), $items_per_page = 0)
{
    $params = array_merge(array(
        'page'              => 1,
        'items_per_page'    => $items_per_page
    ), $params);

    $join = $condition = $limit = '';

    $fields = array(
        '?:order_status_logs.*',
        '?:users.firstname',
        '?:users.lastname'
    );

    $sortings = [
        'order_id' => "?:order_status_logs.order_id",
        'status_from' => "?:order_status_logs.status_from",
        'status_to' => "?:order_status_logs.status_to",
        'user' => ['?:users.lastname', '?:users.firstname'],
        'date' => ["?:order_status_logs.timestamp", "?:order_status_logs.order_id"]
    ];

    $join = "LEFT JOIN ?:users USING(user_id)";

    if (!empty($params['order_id'])) {
        $condition .= db_quote(" AND ?:order_status_logs.order_id = ?i", $params['order_id']);
    }

    if (!empty($params['period']) && $params['period'] != 'A') {
        list($time_from, $time_to) = fn_create_periods($params);

        $condition .= db_quote(" AND (?:order_status_logs.timestamp >= ?i AND ?:order_status_logs.timestamp <= ?i)", $time_from, $time_to);
    }

    if (!empty($params['items_per_page'])) {
        $params['total_items'] = db_get_field("SELECT COUNT(*) FROM ?:order_status_logs $join WHERE 1 $condition");
        $limit = db_paginate($params['page'], $params['items_per_page'], $params['total_items']);
    }

    $sorting = db_sort($params, $sortings, 'date', 'desc');

    $logs = db_get_array(
        "SELECT ?p FROM ?:order_status_logs ?p WHERE 1 ?p ?p ?p",
        implode(',', $fields), $join, $condition, $sorting, $limit, STATUSES_ORDER
    );

    return array($logs, $params);
}
