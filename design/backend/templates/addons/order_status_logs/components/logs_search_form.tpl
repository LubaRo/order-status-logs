<div class="sidebar-row">
    <h6>{__("search")}</h6>
    <form action="{""|fn_url}" name="logs_form" method="get">

        {capture name="simple_search"}
            <div class="sidebar-field">
                <label for="elem_order_id">{__("order_id")}:</label>
                <div class="controls">
                    <input id="elem_order_id" type="text" name="order_id" size="30" value="{$search.order_id}">
                </div>
            </div>

            {include file="common/period_selector.tpl" period=$search.period extra="" display="form" button="false"}
        {/capture}

        {include file="common/advanced_search.tpl"
                 no_adv_link=true
                 simple_search=$smarty.capture.simple_search
                 dispatch="order_status_logs.manage"
                 view_type="order_status_logs"
        }
    </form>
</div>