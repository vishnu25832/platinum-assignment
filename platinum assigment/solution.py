import pandas as pd

tickets = pd.read_excel("ticket.xlsx")
tickets.columns = tickets.columns.str.strip()

# FIX: convert Excel serial to datetime properly
tickets["created_at"] = pd.to_datetime(tickets["created_at"], unit='D', origin='1899-12-30')
tickets["closed_at"] = pd.to_datetime(tickets["closed_at"], unit='D', origin='1899-12-30')

# same day
tickets["same_day"] = tickets["created_at"].dt.date == tickets["closed_at"].dt.date

# same hour
tickets["same_hour"] = tickets["created_at"].dt.hour == tickets["closed_at"].dt.hour

result = tickets.groupby("outlet_id").agg(
    same_day_count=("same_day", "sum"),
    same_hour_count=("same_hour", "sum")
).reset_index()

print(result)