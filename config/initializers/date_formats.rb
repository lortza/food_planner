# See Docs: https://apidock.com/ruby/DateTime/strftime
# Call like: object.created_at.to_fs(:short)

# 05-25-2020
Date::DATE_FORMATS[:default] = "%m-%d-%Y"

# 05/25
Date::DATE_FORMATS[:short] = "%m/%d"

# Sun 05/25 at 7:22 am
Time::DATE_FORMATS[:timestamp] = "%a %m/%d at %l:%M %P"

# 05-25-2020
Time::DATE_FORMATS[:default] = "%m-%d-%Y"