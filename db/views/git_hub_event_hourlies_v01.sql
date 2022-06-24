select
  type,
  date,
  sum(count)
from (
  select
    type,
    date,
    count
  from git_hub_event_hourly_rollups

  union all

  select
    type,
    date,
    count
  from git_hub_event_hourly_queues
) git_hub_event_hourly
group by
  type,
  date
