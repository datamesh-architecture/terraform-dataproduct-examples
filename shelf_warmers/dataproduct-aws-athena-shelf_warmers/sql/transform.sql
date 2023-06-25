with input as (SELECT * from "fulfillment-stock-updated-tk"."stock_updated"),
     all_with_rownumber as (
         select *,
                row_number() OVER (partition by sku, location order by "updated_at" desc) as row_number
         from input
     ),
     potential_shelf_warmers as (
         select sku, location, available, updated_at
         from all_with_rownumber
         where row_number = 1 and available > 0
         order by sku, location
     ),
     all_with_changes as (
         select *,
                available - COALESCE(lead(available) OVER(
                        partition by sku,
                        location order by "updated_at" desc
                    ), 0) as delta
         from input
     ),
     all_sales_last_three_month as (
         select *
         from all_with_changes
         where delta < 0 and from_iso8601_timestamp(updated_at) between
             from_iso8601_timestamp('2007-10-01T00:00:00Z') and
             from_iso8601_timestamp('2008-01-01T00:00:00Z')
     )

select potential_shelf_warmers.location,
       potential_shelf_warmers.available,
       potential_shelf_warmers.updated_at,
       potential_shelf_warmers.sku
from potential_shelf_warmers
         left outer join all_sales_last_three_month on
            potential_shelf_warmers.sku = all_sales_last_three_month.sku and
            potential_shelf_warmers.location = all_sales_last_three_month.location
order by potential_shelf_warmers.sku, potential_shelf_warmers.location
