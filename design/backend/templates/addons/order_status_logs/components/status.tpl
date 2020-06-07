{assign var="description" value=$statuses_descr.$status}
<div class="order-status-logs status-block">
    <span class="o-status-{$status|lower}">{$description}</span>
</div>