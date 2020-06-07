{capture name="mainbox"}

<form action="{""|fn_url}" method="post" name="banners_form" class=" cm-hide-inputs" enctype="multipart/form-data">
<input type="hidden" name="fake" value="1" />
{include file="common/pagination.tpl" div_id="pagination_contents_order_status_logs"}

{assign var="c_url" value=$config.current_url|fn_query_remove:"sort_by":"sort_order"}

{assign var="rev" value=$smarty.request.content_id|default:"pagination_contents_order_status_logs"}
{assign var="c_icon" value="<i class=\"icon-`$search.sort_order_rev`\"></i>"}
{assign var="c_dummy" value="<i class=\"icon-dummy\"></i>"}

{if $logs}
    <div class="table-responsive-wrapper">
        <table class="table table-middle table--relative table-responsive">
        <thead>
        <tr>
            <th width="17%">
                <a class="cm-ajax" href="{"`$c_url`&sort_by=order_id&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("id")}{if $search.sort_by == "order_id"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a>
            </th>
            <th width="17%">
                <a class="cm-ajax" href="{"`$c_url`&sort_by=status_from&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("order_status_logs.status_from")}{if $search.sort_by == "status_from"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a>
            </th>
            <th class="mobile-hide" width="5%">&nbsp;</th>
            <th width="17%">
                <a class="cm-ajax" href="{"`$c_url`&sort_by=status_to&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("order_status_logs.status_to")}{if $search.sort_by == "status_to"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a>
            </th>
            <th>
                <a class="cm-ajax" href="{"`$c_url`&sort_by=user&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("user")}{if $search.sort_by == "user"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a>
            </th>
            <th width="15%">
                <a class="cm-ajax" href="{"`$c_url`&sort_by=date&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("date")}{if $search.sort_by == "date"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a>
            </th>
        </tr>
        </thead>

        <tbody>
        {foreach from=$logs item=log}
        <tr>
            <td data-th="{__("id")}">
                <a href="{"orders.details?order_id=`$log.order_id`"|fn_url}" class="underlined">{__("order")} <bdi>#{$log.order_id}</bdi></a>
            </td>
            <td data-th="{__("order_status_logs.status_from")}">
                {include file="addons/order_status_logs/components/status.tpl" status=$log.status_from statuses_descr=$statuses_descr}
            </td>
            <td class="left mobile-hide order-status-logs-arrow"><i class="icon-long-arrow-right"></i></td>
            <td data-th="{__("order_status_logs.status_to")}">
                {include file="addons/order_status_logs/components/status.tpl" status=$log.status_to statuses_descr=$statuses_descr}
            </td>
            <td data-th="{__("user")}">
                <a href="{"profiles.update?user_id=`$log.user_id`"|fn_url}">{$log.lastname}{if $log.firstname && $log.lastname}&nbsp;{/if}{$log.firstname}</a>
            </td>
            <td data-th="{__("date")}">
                {$log.timestamp|date_format:"`$settings.Appearance.date_format`, `$settings.Appearance.time_format`"}
            </td>
        </tr>
        {/foreach}
        </tbody>
        </table>
    </div>
{else}
    <p class="no-items">{__("no_data")}</p>
{/if}

{include file="common/pagination.tpl" div_id="pagination_contents_order_status_logs"}

</form>

{/capture}

{capture name="sidebar"}
    {include file="addons/banners/views/banners/components/banners_search_form.tpl" dispatch="banners.manage"}
{/capture}

{include file="common/mainbox.tpl"
         title=__("order_status_logs")
         content=$smarty.capture.mainbox
         sidebar=$smarty.capture.sidebar
}