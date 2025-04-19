
function one_month_after(date)
    local t = os.date("*t", date)
    t.month = t.month + 1
    return os.date("%d/%m/%Y %X", os.time(t))
end

function day_of_week(date)
    local t = os.date("*t", date)
    return t.wday
end

function seconds_by_today(date)
    local t = os.date("*t", date)
    t.hour = 0
    t.min = 0
    t.sec = 0
    return os.difftime(date, os.time(t))
end

function first_friday(year)
    -- Exercise 12.4: Write a function that takes a year and returns the day of its first Friday.
    local d = os.date("*t", os.time{year = year, day=1, month=1})
    d.day = d.day + (d.wday <= 6 and (6-d.wday) or 6)
    local newdate = os.date("*t", os.time(d))
    print(os.date("%a %d-%b-%y", os.time(d)))
    return newdate.yday
end

function complete_days(date2, date1)
    -- Exercise 12.5: Write a function that computes the number of complete days between two given dates.
    return os.difftime(date2, date1) // (24*3600)
end

function complete_months(date2, date1)
    -- Exercise 12.6: Write a function that computes the number of complete months between two given dates.
    -- complete month is 30day
    return os.difftime(date2, date1) // (30*24*3600)
end

function system_time_zone()
    -- Exercise 12.8: Write a function that produces the system's time zone.

end

function exercise()
    print("START EX12.1")
    print(one_month_after(os.time()))
    print("START EX12.2")
    print(day_of_week(os.time()))
    print("START EX12.3")
    local sec = seconds_by_today(os.time())
    print(sec, "hh", (sec // 60) // 60, "mm", (sec // 60) % 60)
    print("START EX12.4")
    print(first_friday(2028))
    print("START EX12.5")
    print(complete_days(os.time()+(56*3600), os.time())) -- 56 hours, should return 2 days
    print("START EX12.6")
    print(complete_months(os.time()+(80*24*3600), os.time())) -- 80 days, 2 months
    print("START EX12.7")
    --Exercise 12.7: Does adding one month and then one day to a given date give the same result as adding
    -- day and then one month? no because of our calendar
    -- 30 april + 1 day is 1st may, +1 month is 1st june
    -- 30 april + 1 month is 30 may, +1 day is 31may
    local d1 = os.date("*t", os.time({year=2025, month=4, day=30}))
    local d2 = os.date("*t", os.time({year=2025, month=4, day=30}))
    d1.month = d1.month + 1
    d1 = os.date("*t", os.time(d1))
    d1.day = d1.day + 1
    d1 = os.date("*t", os.time(d1))

    d2.day = d2.day + 1
    d2 = os.date("*t", os.time(d2))
    d2.month = d2.month + 1
    d2 = os.date("*t", os.time(d2))
    print("d1", os.date("%a %d-%b-%y", os.time(d1)))
    print("d2", os.date("%a %d-%b-%y", os.time(d2)))
    print(os.date("%z", os.time()))
    print(os.date("%Z", os.time()))


end


exercise()
